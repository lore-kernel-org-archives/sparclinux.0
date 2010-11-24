From: David Daney <ddaney@caviumnetworks.com>
Date: Wed, 24 Nov 2010 17:18:06 +0000
Subject: Re: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <4CED48CE.5060300@caviumnetworks.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>
	<fa44e045-9600-4c46-939a-af246afab4f6@VA3EHSMHS019.ehs.local>
In-Reply-To: <fa44e045-9600-4c46-939a-af246afab4f6@VA3EHSMHS019.ehs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Cc: linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org

On 11/24/2010 09:02 AM, Stephen Neuendorffer wrote:
>
>
>> -----Original Message-----
>> From: linuxppc-dev-bounces+stephen=neuendorffer.name@lists.ozlabs.org [mailto:linuxppc-dev-
>> bounces+stephen=neuendorffer.name@lists.ozlabs.org] On Behalf Of Michael Ellerman
>> Sent: Wednesday, November 24, 2010 6:04 AM
>> To: LKML
>> Cc: linux-mips; microblaze-uclinux@itee.uq.edu.au; devicetree-discuss@lists.ozlabs.org; linuxppc-dev
>> list; sparclinux@vger.kernel.org
>> Subject: RFC: Mega rename of device tree routines from of_*() to dt_*()
>>
>> Hi all,
>>
>> There were some murmurings on IRC last week about renaming the of_*()
>> routines. I was procrastinating at the time and said I'd have a look at
>> it, so here I am.
>>
>> The thinking is that on many platforms that use the of_() routines
>> OpenFirmware is not involved at all, this is true even on many powerpc
>> platforms. Also for folks who don't know the OpenFirmware connection it
>> reads as "of", as in "a can of worms".
>>
>> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
>> it would be nice to get rid of, but it's a lot of churn.
>>
>> So I'm hoping people with either say "YES this is a great idea", or "NO
>> this is stupid".
>
> Personally, I think it's a great idea, if only because I stared long and hard
> at the code once upon a time trying to figure out what is really OF-related
> and what isn't.  It's somewhat clearer now that drivers/of has been factored
> out (although, shouldn't it be drivers/dt???)
>
> That said, it *is* alot of code churn.  If it's going to be done, I think it should be
> done in concert with fixing a bunch of the function names which don't really follow any
> sane naming convention, so that the backporting discontinuity only happens once.
>

Oh, you mean things like:

of_{,un}register_platform_driver vs. platform_driver_{,un}register

That one is particularly annoying to me.

David Daney
