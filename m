From: Admar Schoonen <admar@luon.net>
Date: Thu, 23 Sep 2004 15:17:45 +0000
Subject: Re: 2.6.8.1 and XFree86
Message-Id: <20040923151745.GG31137@azrael.luon.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1092597725.2550.7.camel@iota>
In-Reply-To: <1092597725.2550.7.camel@iota>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On my Ultra 5, linux kernel 2.6.7 runs fine but after that (2.6.8-rc1
> and on, no change with 2.6.8.1) XFree86 gets this message:

[snip, X server gest signal 11]

> I'm running Debian Unstable.
> Any way to solve this issue?

I have exactly the same problem on my blade 100. I expected the problem
to be with the 2nd framebuffer as my ultra 5 works fine and has only 1
fb. I haven't found the time yet to open up the blade 100 and try X with
2.6.8 and only 1 framebuffer.

Both my machines are running debian unstable. Only the blade 100 has a
second framebuffer (Ati mach64, 8 MB, same as on board chip, but on a
pci card). Ultra 5 has a slightly older Ati mach64 4 MB onboard.

Do you have a second framebuffer in your ultra 5?
And do you have a working X with 2.6.8 already?

Best regards

Admar
