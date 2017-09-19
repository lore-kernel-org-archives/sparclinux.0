From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 19 Sep 2017 21:24:11 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <CADxRZqzTp1BN4YObgYgXTc9KTSaM8RbcC4=AEdROtDn-v12v7A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Sep 19, 2017 at 11:29 PM, David Miller <davem@davemloft.net> wrote:
> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date: Tue, 19 Sep 2017 21:43:47 +0200
>
>> We have many Debian users who want to install Linux on their SPARC
>> boxes. But not all of them are hardcore experts that can deal with
>> 15-year-old userland tools which no one knows anymore these days and
>> which they have to Google search first before they can download,
>> build and install them.
>
> Nobody has to download and install anything.
>
> You are showing that you do not even know what packages exist
> in Debian.
>
> 'prtconf' has been in the sparc-utils package for probably like
> two decades.

By the way, David, what is mdlint you mentioned earlier? I'm surprised
to hear about it for the first time in my sparc linux adventure.
Google seem doesn't know anything about it, and I failed to find it
with "mdlint linux sparc" / "linux sparc wiki mdlint"
Solaris does not have it (being I'm only 10 years with solaris
starting from version 9).
Why don't we have it in sparc-utils along with prtconf and eeprom?

On the final note, why can't we have nice things together? Like proper
utility to parse MD (machine description) via binary /dev and some
kind (but user friendly) sysfs interface? Really, sysfs is so much
easier for a user (like me), let it be (even if it's incomplete) !?
Linux kernel is full of such examples, where device access is done via
/dev and auxiliary information is available via sysfs.

Thanks!
