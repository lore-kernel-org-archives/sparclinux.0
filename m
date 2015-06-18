From: David Mattli <dmm@mattli.us>
Date: Thu, 18 Jun 2015 16:51:23 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <87ioalarjo.fsf@mattli.us>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I've submitted a bug to Debian against src:linux requesting that they
enable SLUB on the sparc kernel because in my testing a SLUB kernel
never shows an error with Knight's test program and a SLAB kernel shows
it within seconds.

Enabling SLUB also fixes the nettle FTBFS.

I'd appreciate if you can help by making this change to the linux
package, adding information to the bug or by confirming whether the
proposed workaround works for you.

Here's the src:linux bug:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bugx9180

And the nettle FTBFS bug:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bugx9013

Thanks!
David Mattli
