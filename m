From: Turbo Fredriksson <turbo@swe.net>
Date: Mon, 13 Dec 2004 07:34:24 +0000
Subject: SPARC64 Warmboot fails - 'version 2.84 booting' and then hang
Message-Id: <87is76k5xb.fsf@papadoc.bayour.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm running 2.6.8.1 with some patches I found on this list
on my SPARC64 (Sun Blade 1000 - 2xUltraSPARC-III/750MHz).

But every (!) time I reboot, it hangs just after the line

    [...]
    md: ... autorun DONE.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: mounted filesystem with ordered data mode.
    VFS: Mounted root (ext3 filesystem) readonly.
    version 2.84 booting
    [hung!]


I'm booting over serial port (no graphics, usb etc compiled
in).

Cold boot almost always work (unless I have other problems
with the system - it's never the kernels fault if it fails),
but not warm boots...

Anyone have any idea? What can I do to find/pinpoint the problem?
