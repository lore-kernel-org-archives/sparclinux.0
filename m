From: "Eric Brower" <ebrower@gmail.com>
Date: Tue, 17 Jun 2008 15:46:13 +0000
Subject: Re: unify sparc and sparc64 headers
Message-Id: <ec7cefb0806170846p2bf77a89g8aed7da6d95cfc8f@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080613195449.GA9141@uranus.ravnborg.org>
In-Reply-To: <20080613195449.GA9141@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 17, 2008 at 12:02 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Mon, Jun 16, 2008 at 04:33:03PM -0700, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Fri, 13 Jun 2008 21:54:49 +0200
>>
>> > The full set can be pulled from:
>> >
>> >    ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc.git
>> >
>> > And will follow as mails too.
>>
>> This looks OK.
>>
>> About asm/openprom.h, I am very sure we can kill that export to
>> userspace.  The only real user is the SILO boot loader and nowadays
>> SILO includes it's own copy of the kernel headers it needs so we can
>> safely remove the export on the kernel side.
>
> The purpose of exporting kernel headers to
> user space is to get rid of all the local copies so this
> seems as a wrong argument to remove the export. We should
> instead ask SILO to use the kernel exported version.
>
> Looking at the SILO sources I would say that the kernel should
> use a copy from the SILO source as that version are far better
> documented than the kernel version. And then export that version.
>
>        Sam

The current methodology of copying kernel header files into user-space
application sources has always perplexed me.  Does this indicate there
is talk or activity around changing this methodology, or are you
pushing towards such an agenda, Sam?  Not subscribing to LKML, perhaps
I'm a bit out of the loop.

Thanks,
E



-- 
E
