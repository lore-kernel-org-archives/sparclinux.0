From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 16 Jan 2009 23:39:28 +0000
Subject: Re: Unknown CPU in 2.6.29-rc1
Message-Id: <646765f40901161539r426ca0acqff16392e881de4ff@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901161249030.2120@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901161249030.2120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jan 17, 2009 at 04:18, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Jan 16, 2009 at 10:11:49AM -0600, Dennis Gilmore wrote:
>> On Friday 16 January 2009 08:32:17 am you wrote:
>> > On Fri, Jan 16, 2009 at 12:58:32PM +0200, Meelis Roos wrote:
>> > > After Sam's insw/... fix, todays 2.6.29-rc1+git boots up and seems fo
>> > > work on E3500 with 2 USII-400's. However, the CPU has suddenly became
>> > > unknown (it was known in 2.6.27):
>> > >
>> > > [  136.434591] CPU: Unknown chip, impl[0x17] vers[0x11]
>> > > [  136.434649] FPU: Unknown chip, impl[0x17] vers[0x11]
>> >
>> > Did you expect:
>> > CPU: TI UltraSparc II  (BlackBird)
>> > FPU: UltraSparc II integrated FPU
>> >
>> > Ohh, I see why.
>> > The sucker that updated kernel/cpu.c did a poor job doing so.
>> > (For reference: it was me)
>> >
>> > I assume manufacturer_info can be indexed but it needs to be searched.
>> > Will likely fix tonight if you do not beat me.
>> >
>> > I think I know why I did this mistake, as I really did not make up
>> > my mind what approach to use and ended up mixing it.
>> >
>> > [For the record I do not have a sparc to test it on.
>> > My SUN Blade 100 are cauing me troubles..]
>> if its locking up regularly try appending ide=nodma to the kernel line.
>
> It gave a few strange errors.
> I read somewhere on a debian forum that they did not expect the CD
> based install to work and recommended a network based setup.
>
> So I'm planning to do this. It requires RARP (or DHCP), tftp and
> I think one more thing. I just ran out of time when playing with it.

It's fairly easy to set up on another Debian box if you follow the
instructions. (this is how I do all my sparc installs)

If you need a hand, email me.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
