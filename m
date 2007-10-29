From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 29 Oct 2007 23:37:13 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071029233713.GA3177@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

(Sorry for breaking the threading - I didn't subscribe to the list,
I just found this in the web archive. I should probably subscribe... :)

David Miller wrote:
> Ok, since I have a 280R just like Josip, I think a good plan
> is for him to show me the commands he used to create the
> build root where he can trigger bad things.

I can't be 100% sure, because it was James Troup who initially set it up,
but I believe that the chroot on lebrun.d.o was set up by just doing
something mundane like running debootstrap, more specifically something
like this:

sudo debootstrap lenny /mnt http://ftp.us.debian.org/debian

I conclude this because it has a var/log/bootstrap.log in it,
dated 2007-06-19 12:15, which has:

Selecting previously deselected package base-files.
(Reading database ... 0 files and directories currently installed.)
Unpacking base-files (from .../base-files_4.0.0_sparc.deb) ...
[...]
Setting up build-essential (11.3) ...

And it also has a var/log/dpkg.log which has:

2007-06-19 12:13:10 install base-files <none> 4.0.0
[...]
2007-06-19 12:15:23 status installed build-essential 11.3

Again I can't be 100% sure of the exact command line used, but that
really should be it :)

After that, dpkg.log in the chroot also has a purge of the 'procps' package,
and an installation of the 'sparc-utils' package. A few hours after those
two, a random selection of package installations starts - the buildd went
online.

I'd try doing a debootstrap of lenny (that's Debian "testing"),
and then inside it, run one or more of those 'dpkg-query -S libc.so.6'.

-- 
     2. That which causes joy or happiness.
