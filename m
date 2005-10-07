From: Pasi Pirhonen <upi@iki.fi>
Date: Fri, 07 Oct 2005 11:19:32 +0000
Subject: TILO
Message-Id: <20051007111932.GA28286@core.upi.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


I don't know if someone of you already know, but i've been working on
target named: CentOS-4/sparc. 

I hjaev been collecting/merging patches, building, testting, building
again past two or so months maybe. Finally having my vacation and time
to work full time with the problem

I did try generate installation images few day ago and realized that i
can't make working TILO-images with anything. Tried even extracting the
tools from Aurora 1.0 to my running system (which made a little diff.
sized images), but those are not booting.

Is there some magic i am not avare of and should that TILO just handle
2.6 kernel allright?

Personally i don't see any point making public a distro that can't be
installed with 'boot net'.

Below is example of process, which does load, but usually die with
'Illegal Instruction'. I think i saw 'MMU missmatch' or something once
on Netra/X1.

[root@c4sp sparc]# tilo -o test.img vmlinuz-2.6.9-22.EC-UNSTRIPPED
initrd64.img 
Converting vmlinuz-2.6.9-22.EC-UNSTRIPPED (sun4u) to a.out:
PT 0 Entry: Loadable to 0x400000[0x3335d0] from 0x0[0x2c6086] align
0x100000
PT 1 Entry: unknown
Compressing vmlinuz-2.6.9-22.EC-UNSTRIPPED.raw:
vmlinuz-2.6.9-22.EC-UNSTRIPPED.raw:      54.5%
Sizes (sun4u):
  raw size     = 2891910
  packed size  = 1316731
  root address = 00000000007335d0
Root image packed size = 2052036
WARNING: Kernel for Sun4c/m/d not specified
Images are large. Will load on machines with at least 5M mapped by PROM
only
TILO size = 3385579



TIA,


-- 
Pasi Pirhonen - upi@iki.fi - http://iki.fi/upi/
