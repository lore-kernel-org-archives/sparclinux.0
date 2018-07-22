From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 22 Jul 2018 20:51:53 +0000
Subject: Re: Unprivileged userland application crashes sparc64 kernel - was: Re: FreePascal testsuite still t
Message-Id: <4cc6f068-8d76-94c3-0a72-cd6f8f1ffb1d@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <da111a90-01bc-7a0f-86db-c908ca2f4a4f@physik.fu-berlin.de>
In-Reply-To: <da111a90-01bc-7a0f-86db-c908ca2f4a4f@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave!

On 07/22/2018 10:49 PM, David Miller wrote:
> I don't have access to any of my sparc64 systems at the moment, but I
> suspect that what might be happening is that the register window state
> gets such that the kernel window trap handlers cannot resolve it and
> we get stuck in the kernel looping either over the window fixup handler
> or the fault resolving paths.

Thanks a lot for your quick answer and the input. We just disable the
test for the time being.

> Sorry, but that is about as much as I can contribute for now.

No worries.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
