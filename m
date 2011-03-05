From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 05 Mar 2011 02:10:17 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq support]
Message-Id: <AANLkTikYs4L_C7q=JGs_Gq7AdbdwEAd=c18SVz09P+Zh@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Mar 5, 2011 at 08:48, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Feb 25, 2011 at 11:06:13PM -0800, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Tue, 22 Feb 2011 19:22:19 +0100
>>
>> > I will prepare a v4 soon.
>>
>> The first 4 patches are in the tree, so you only need to resubmit
>> this patch rather than the whole bunch.
>>
>> I really look forward to applying v4, thanks Sam!
>
> Short update...
>
> I will not post v4 until I can do a bit more testing.
>
> Next week I get a SS1000E box (thanks to Chris <crn@netunix.com>) which
> allows me to test the sun4d changes.
>
> Huge thanks to Chris which has put a lot of effort in getting the
> box operational again and for all the effort concerning the shipping!
> I owe him more than one beer for this...
>
> Kjetil mentioned he would try the genirq patches on his SS1000.
> And I hope to get feedback from Gaisler too.
>
> The patchset will likely not see testing on:
> - sun4m with multiple CPUs

I have one of these, however it currently lacks any way to boot it.

If you could send me your tips for building tftpboot images and stuff,
it'd save me some time.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
