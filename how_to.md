1. ssh KatanaPi@192.168.0.12 / katanaroot
2. USB stick has cryprographic key to enable to SSH /
3. Lnux: ssh root@192.168.10.120 / katanaroot
Linux:
if I change anything in kecm/conf we need to set a flag to safe those changes after reboot
cd /kecm/flags
touch conf_updated (?)
- 

4. QNX from Linux : ssh root@172.16.0.1 / root

- How to build USB stick

Currently we have a script on an encrypted USB drive that uses an RSA 4096bit encryption key to sign a sha256 hashed file whose contents are a string+USB's serial number" The public side of this key is in our build, and it can decrypt and authenticate the file, so if it authenticates AND the usb serial number in the file matches the serial number of the usb key, then it is considered valid. You can see the two sides of the implementation (minus the private key itself) here:
Create Keys: https://eng.plexus.com/git/projects/A2631/repos/kem-tools/browse/usb_provisioning/make_usb_key.sh
Verify Keys on KECM: https://eng.plexus.com/git/projects/A2631/repos/kem-sw/browse/apps/kecm_usb/kecm_verify_usb.sh


-- what Josh uploaded

So I have uploaded a lot of data to teams, you may want to remove it once you have downloaded it (~15GB)

There are 3 things (SergeySupport):

·       yocto build docker image

·       kem-sw apps building docker image

·       /tools directory from kem-sw after a successful apps build

in theory these docker images can be used by referencing them with docker load < filename. We have never done this though so I can’t verify, you may need to play with it some. Additionally/alternatively, you may be able to edit the .devcontainer json file to point at these images; you’ll need to lookin into the format of that devcontainer setup in vscode.
for kem-sw then you will need to load the /tools from the zip file to get all the downloaded binaries from artifactory/conan. Again we have never tried do things this way, but this was the easiest way I could see to grab all the binaries we use in the build process. What will be needed to point to them is probably the biggest challenge.


-- how to check

2.3.4.1 Spectral Management and Analysis on Safety OS

The Katana ECM Software shall execute all spectral management and analysis features under the safety operating system.
Rationale:
A safety operating system is a safety certified medical grade operating system designed for Class C software; all portions of the Katana ECM Software system contributing to capture and analysis of any safety critical data should be run in a medical grade environment.
Verification Method:
From a console on Linux, use 'ps' command to list processes and demonstrate no spectral related processes are executing using lsusb demonstrate that there is no spectrometer connected to Linux, from a console on QNX use the 'ps' command to list processes and demonstrate that spectral manager is running, use the 'usb -vvv' cmd to verify a spectrometer is connected to QNX.

- 2.3.9.13 Enable SELinux
The Katana ECM Software shall enable selinux in enforcing mode using a targeted policy.
Rationale:
selinux provides limitations on access by processes to limit potential escalation based attacks.
Verification Method:
Run sestatus command, verify status is enabled, and that policy contains targeted and mode is enforcing.

-- how to compile Linux version of the applications

- load kem_sw docker image
	- user@ubuntu:~/artifacts$ docker load < kem-sw_docker_202306300631.tar.xz
	
- copy tools.zip, build.zip,
	- copy artifacts downloaded from Josh
	From Ubuntu terminal
	- user@ubuntu:~/artifacts$ cp build.zip ~/katana/kem-sw/
	- user@ubuntu:~/artifacts$ cp tools.zip ~/katana/kem-sw/
	From VScode terminal
	- vscode ➜ /home/user/katana/kem-sw (master ✗) $ unzip tools.zip -d /
	- vscode ➜ /home/user/katana/kem-sw (master ✗) $ unzip build.zip

- build
	From VSCode terminal
	vscode ➜ /home/user/katana/kem-sw (master ✗) $ rm /home/user/katana/kem-sw/build/CMakeCache.txt
	From VSCode
	- CMake: [Debug no_covereage]
	- [Yocto aarch64-poky-linux-GCC]
	- Build [telemetry/smectra_manager]
	- Build


-- how to build upgrade bundle
the upgrade bundle is built separately from the main yocto build. There are instructions here:
https://eng.plexus.com/git/projects/A2631/repos/docs/browse/sdg/repos/yocto-repo.md
under the upgrade header

-- main steps to upgrade ECM SW
The current steps are to put a generated secure upgrade bundle on a usb stick. then insert the stick.It should upgrade automatically in a minute or two, you can ssh in and watch the system long for messages indicating its done. Then you would remove the stick and reboot.

-- booting time
Its about ~1:20 or so
The biggest chunk of time is the rootfs crc process
It takes ~30-45s all by itself 


--- what USB to Serial for 
>> USB to Serial adapter is used to access QNX’s serial console.
-       Since this provides unsecured root access to all parts of the system, it will be disabled as we approach a more final software release… but until then the serial console is the easiest way to work on QNX functionality that happens too early in the boot process for SSH to be an option.

 
-- what micro-USB port is for
>> The only function of the micro-USB port right now is to flash software onto the unit’s eMMC storage when it is placed into serial download mode:
-       The intent is for this to eventually ONLY be used during the initial manufacturing process for a unit, after which we will permanently disable serial download mode by burning some fuses within the processor so that it is only possible to change the software through “official” upgrade methods.
-       Since this is not reversible, we have only done it as a proof of concept on one SOM and are not planning to do it to any units until we are closer to a final software release; just in case we need to completely re-flash an ECM running older software that is incompatible with current/future upgrade packages.


# get windows key / activate / activation / 
wmic path SoftwareLicensingService get OA3xOriginalProductKey
Y7XFJ-D7N2P-4PY42-99W2H-7QXCT
 - activate in settings


#check ECM connectivity with Laser

If I understand you want to test just the hardware level at first? So you intend to connect to laser simulator, power up, disconnect from simulator and connect to real laser hw and do X to test that there is some minimal successfully communication?

The first thing I would do after connecting is from Linux or QNX, ping 192.168.10.2 Verify that works

Then from Linux I’d use curl to test that the https seems to work:
curl -X POST -H 'Content-Type: application/json' -d '{"jsonrpc": "2.0", "method": "getStatus", "params":"","id":1}' -k https://192.168.10.2

Finally In QNX I’d restart spectral manager, and see that it stays functional
// pidin ar |grep –I [sp]ec is not empty
pidin ar |grep –i [s]pec

and that the log doesn’t have socket timeouts
slog2info –W |grep –I socket|timeout

/kecm/logs/non_spectral_events
cat *.txt, for current session

Simulator:


Linux

curl -X POST -H 'Content-Type: application/json' -d '{"jsonrpc": "2.0", "method": "getStatus", "params":"","id":1}' -k https://192.168.10.2

QNX Terminal

flags
ssh root@172.16.0.2
yes
katanaroot
curl -X POST -H 'Content-Type: application/json' -d '{"jsonrpc": "2.0", "method": "getStatus", "params":"","id":1}' -k https://192.168.10.2

# QNX Software center

~/qsc_install/qnxsoftwarecenter$ ./qnxsoftwarecenter

