From: "Stephen P. Becker" <geoman@gentoo.org>
Date: Tue, 21 Sep 2004 13:24:02 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <41502B72.1050205@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

For what it's worth, I used to have 2x200 UltraSPARCI processors in my 
Ultra2.  I could not get it to boot via nfsroot using a 2.6.7 kernel 
(HME started resetting itself over and over just as it mounted the 
nfsroot) unless I disabled SMP.  I didn't have any such problems once I 
got my 2x300mhz UltraSPARCII processors.

Steve

Matt R Hall wrote:
> I filed a report about this in kernel.org's bugzilla and it has not
> received any comments. I would appreciate it if people could read this
> and provide input. Here is a shortened version of the full report:
> 
> Distribution: Debian Unstable (Sid) 2004-09-20
> Hardware Environment:
> Sun Ultra Enterprise II
> 2x200 mHz UltraSPARC I Processor
> 512MB RAM
> 2x4.3GB 7200RPM SCSI Disc
> Toshiba SCSI CD-ROM
> 
> Kernel configuration and dmesg output are pasted below for reference purposes.
> 
> Software Environment:
> Standard Debian Unstable System
> 
> Problem Description:
> Sun Ultra Enterprise 2 was hardlocking in 2.6.xx. Never responded to keyboard
> input. Sometimes would respond to pings and SSH connections for a while, but
> would always lock hard eventually with no errors. Note that this exact same
> system works perfectly in 2.4.xx. I reiterate, SMP functions correctly there.
> Obviously something has changed and caused functionality to break, hence why I
> have marked this bug high severity. IMHO, "stable" kernel series should not
> result in a step back in hardware compatibility.
> 
> Disabling SMP resulted in a working system.
> 
> Steps to reproduce:
> Compile with the following kernel configuration, except add the SMP option.
> Witness the machine fail to continue functioning.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

