From: Jan Engelhardt <jengelh@medozas.de>
Date: Sat, 16 Jan 2010 01:05:54 +0000
Subject: Something's up with mondo
Message-Id: <alpine.LSU.2.01.1001160159400.29759@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


I just picked up this trace at the end of a poweroff(8) run. [The 
machine did not turn off either, but that may be due to my userspace]

Stopping udevd:                                                      
done
Sending all processes the TERM signal...                             
done
pidofproc: cannot stat /sbin/splash: No such file or directory
Sending all processes the KILL signal...                             
done
The system will be halted immediately.
md: stopping all md devices.
sd 0:0:0:0: [sda] Synchronizing SCSI cache
Power down.
CPU[13]: SUN4V mondo timeout, no forward  progress after 10001 retries.
CPU[13]: CPU list [ 4 ]
CPU[13]: SUN4V mondo timeout, no forward  progress after 10001 retries.
CPU[13]: CPU list [ 4 ]
[...]
