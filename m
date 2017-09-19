From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 19 Sep 2017 15:55:52 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <CADxRZqwJDYOPxy-h3G1JNZQEScxE9tNHfrsZC5trSFyfNkjmLA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Sep 18, 2017 at 7:43 PM, David Miller <davem@davemloft.net> wrote:
> From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
> Date: Mon, 18 Sep 2017 15:23:57 +0100
>
>> The aim of this patch is to ease browsing mdesc and implement
>> utilities like lshw. If you look at lshw sources, you'll see that they
>> make a real huge use of sysfs, the only binary device they use is for
>> DMI tables (via /dev/dmi if present, or by directly accessing mmap'ed
>> physical memory otherwise)
>
> So you're telling me that there is support for image based handling in
> the tool for the sake of DMI, so the tool could therefore just as
> easily handle the current mdesc export format as well.
>
>> Also, since mdesc is basically a tree it maps well to a filesystem
>> structure like sysfs.
>
> We don't export identical information two different ways in the kernel.
>
> We have /dev/mdesc already.
>
> For the other cases, sysfs was done first.  It wasn't duplicating an
> existing mechanism.
>
> I still stand by my decision, sorry.

David,

please, lets not make/introduce another tool for parsing /dev/mdesc,
it's so easier to use sysfs , instead of using another arch-specific
(sparc64) tool, like prtconf.

For example, virt-what, systemd-detect-virt or ansible (facts module,
virtualization) could simply look for file(s) in mounted sysfs,
instead of calling another external utility (which should be installed
before in choosen linux $distribution) or each one writting its own
internal parser for /dev/mdesc.

Thanks.
