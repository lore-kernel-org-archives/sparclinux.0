From: dree <dree@gnulinux.nl>
Date: Thu, 29 Jan 2004 22:20:53 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <401A0E39.4030100@gnulinux.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

on my ultra10, 128MB, 440Mhz ,running sid:
a vanilla 2.6.1 vmlinux kernel size 3.8 MB boots fine
a 2.4.19 vmlinux kernel size 1.3MB boots fine
a 2.4.24 image image kernel size 3.1 MB boots fine
a 2.4.18-sun4u vmlinux kernel size  1.4 MB boots fine

a 2.6.2-rc2 vmlinux lernel size 3.8 doesn't boot, as reported earlier.
    booting that kernel with "-p" gives:
      Remapping the kernel... done.
      On node 0 totalpages: 15846
I did not however have to use debian-rescue to rerun "silo -f" again.

All my old kernels work without hassle. All in all a fine job.
Thanks for the effort Ben , now we can use the shiny new kernel-build 
system, just like the normal people :)

I used the silo-loaders tar-ball for second.b.

       Andreas
