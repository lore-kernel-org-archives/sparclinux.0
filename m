From: Kent Tong <kent@cpttm.org.mo>
Date: Tue, 26 Jul 2005 10:58:27 +0000
Subject: fd0 not found
Message-Id: <42E61753.8050502@cpttm.org.mo>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I'm running Debian Sarge (kernel 2.6) on a Sun Blade 100.
I tried to to format my floppy using "fdformat /dev/fd0h1440"
but it says "no such device or address". In addition, mesg
shows there is an error:

SABRE0: Uncorrectable Error, primary error type[DMA Write:Translation Error]
SABRE0: bytemask[00ff] dword_offset[0] was_block(0)
SABRE0: UE AFAR [000000005fa7c000]
SABRE0: UE Secondary errors [(none)]
SABRE0: IOMMU Error, type[Invalid Error]
SABRE0: IOMMU TAG(4)[RAW(0000000000c6f800)error(Invalid 
Error)wr(0)sz(8K)vpg(df0
00000)]
SABRE0: IOMMU 
DATA(4)[RAW(000000006fe00000)valid(1)used(1)cache(0)ppg(0000000000
000000)

and it doesn't mention anything about floppy or fd at all.
Any idea?

Thanks!

-- 
Kent Tong, Msc, MCSE, SCJP, CCSA, Delphi Certified
Manager of IT Dept, CPTTM
Authorized training for Borland, Cisco, Microsoft, Oracle, RedFlag & RedHat

