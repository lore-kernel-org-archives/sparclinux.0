From: dree <dree@gnulinux.nl>
Date: Mon, 02 Feb 2004 09:07:32 +0000
Subject: Re: SILO 1.4.2 released :(now 1.4.4)
Message-Id: <401E9B6A.1040808@gnulinux.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
earlier I reported:

> a 2.6.2-rc2 vmlinux lernel size 3.8 doesn't boot, as reported earlier.
>    booting that kernel with "-p" gives:
>      Remapping the kernel... done.
>      On node 0 totalpages: 15846 

It was said that waiting for rc3 would fix it, as indeed it did.
2.6.2-rc3 vmlinux with size 3.4M boots fine using silo 1.4.4

Just for kicks, I also compiled a large kernel for testing.
2.6.2-rc3 vmlinux with size 6.3M boots fine using silo 1.4.4

I used the silo-loaders-1.4.4 tarball.
ultra10, 128MB, 440Mhz ,running sid.

    Andreas
