From: Nick Krause <xerofoify@gmail.com>
Date: Fri, 18 Jul 2014 19:51:00 +0000
Subject: Re: Sparc: Fix Mes in highmem.c
Message-Id: <CAPDOMVhNqy-Zm9GMr5-yiY2KHarH7_qYiWM9BQcfJmeMdyYcUw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAPDOMVjTxTNTfgPJMz6eNfabXuvtJ43YMpEeDEQ236EtF168Cg@mail.gmail.com>
	<20140717075204.GA15569@ravnborg.org>
	<CAPDOMVjb_JxnGSTf5mW_RQ58h4-7fS6HywARpPV3XgWA33SybQ@mail.gmail.com>
	<CAPDOMVj9GcoC26Sp6sOmwZf39mfOn=Wy87AnfzDguthcFOTXhg@mail.gmail.com>
	<20140718140812.GB23985@home.goodmis.org>
	<CAPDOMVji-rOr4OT0M+RX0XaKLsscH_PJ8Q0BEw3xyp34KjHOKA@mail.gmail.com>
	<20140718182028.GA21570@ravnborg.org>
In-Reply-To: <20140718182028.GA21570@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jul 18, 2014 at 2:20 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Jul 18, 2014 at 01:06:41PM -0400, Nick Krause wrote:
>> On Fri, Jul 18, 2014 at 10:08 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Thu, Jul 17, 2014 at 11:05:12PM -0400, Nick Krause wrote:
>> >> On Thu, Jul 17, 2014 at 1:38 PM, Nick Krause <xerofoify@gmail.com> wrote:
>> >> > On Thu, Jul 17, 2014 at 3:52 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> >> >> On Wed, Jul 16, 2014 at 10:25:30PM -0400, Nick Krause wrote:
>> >> >>> I am hitting three Fix mes in this file and am wondering as the
>> >> >>> maintainer how you would like
>> >> >>> to clean them up.
>> >> >>
>> >> >> They may be addressed if we one day decide to give the sparc32 highmem
>> >> >> support a big overhaul. Until then they are left as is.
>> >> >>
>> >> >>         Sam
>> >> >  Very well then I will just not touch it until we are going to
>> >> > overhaul the highmem  for
>> >> > sparc32.
>> >> > Cheers Nick
>> >> If you want I can fix the sparc32 highmem area with your help. I am new
>> >> to the kernel so a little help if needed would be great when doing this work
>> >> for you:).
>> >
>> > It will take a bit more than a "little help" to do such a task. Among other
>> > things, owning a sparc32 box is one of them. Do you happen to have one?
>> > Or do you have access to one?
>> >
>> > -- Steve
>> >
>>
>> I understand that I don't have a sparc32 box , however if someone can
>> test my fixes for me this
>> may work.
> No it will not work.
> This is as many other areas something that require some knowledge plus
> some trial-and-error to do.
>
> You should understand that things takes time to learn before you can go hacking
> around in stuff. And highmem support in sparc32 is one such area.
> Time are in some areas counted in months and in other areas counted in years.
> This is not some simple userspace program - please try to understand this.
>
>         Sam


Ok that's fine. I just thought I could help. If there is anything
please let me known.
Cheers Nick
