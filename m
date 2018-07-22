From: David Miller <davem@davemloft.net>
Date: Sun, 22 Jul 2018 20:49:01 +0000
Subject: Re: Unprivileged userland application crashes sparc64 kernel - was: Re: FreePascal testsuite still t
Message-Id: <20180722.134901.1661284795287016862.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <da111a90-01bc-7a0f-86db-c908ca2f4a4f@physik.fu-berlin.de>
In-Reply-To: <da111a90-01bc-7a0f-86db-c908ca2f4a4f@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 22 Jul 2018 22:45:39 +0200

> I have opened a bug in the kernel bugzilla now, see:
> 
>> https://bugzilla.kernel.org/show_bug.cgi?id 0625

I don't have access to any of my sparc64 systems at the moment, but I
suspect that what might be happening is that the register window state
gets such that the kernel window trap handlers cannot resolve it and
we get stuck in the kernel looping either over the window fixup handler
or the fault resolving paths.

Sorry, but that is about as much as I can contribute for now.

Thanks.
