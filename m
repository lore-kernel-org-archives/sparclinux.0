From: Meelis Roos <mroos@linux.ee>
Date: Mon, 22 May 2006 21:43:00 +0000
Subject: Re: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <Pine.SOC.4.61.0605230039001.743@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Last week I had several cases of corruption in dpkg database (status and 
> available files). These happened with different 2.6.17-rc3 + git kernels, the 
> last tested kernel was 2.6.17-rc3-ge515f048 from May 9. Then I booted up 
> Debian default kernels (2.6.16-1-sparc64) and it seems to work just fine, no 
> corruption so far.
>
> I suspected both dpkg and kernel but this seems to point finger to the side 
> of kernel.

Some further testing has narrowed it down to
2.6.17-rc1-g676165a8 probably OK (debian apt-get upgrade succeeded)
2.6.17-rc2 bad (first package broke dpkg status file)

There were 2 consecutive overwritten pieces in status file (sometimes 
there are more). Both wer inside the Description: filed (and most 
changes have usually been, not sure about 100%). The remaining data is 
not shifted, just overwritten.

File offsets of the overwritten data are 0x7DE18-0x7DE36 
and 0x7DED7-0x7DF36. Not aligned at the beginning and not the same size.

-- 
Meelis Roos (mroos@linux.ee)
