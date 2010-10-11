From: David Miller <davem@davemloft.net>
Date: Mon, 11 Oct 2010 04:11:20 +0000
Subject: Re: [PATCH 1/7] sparc: make drivers/of/pdt.c no longer sparc-only
Message-Id: <20101010.211120.189701946.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20101010014358.30cb74b5@debxo>
	<20101011041010.GB23588@angua.secretlab.ca>
In-Reply-To: <20101011041010.GB23588-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 10 Oct 2010 22:10:10 -0600

> On Sun, Oct 10, 2010 at 01:43:58AM -0700, Andres Salomon wrote:
>> 
>> Clean up pdt.c:
>>  - make build dependent upon config OF_PROMTREE
>>  - #ifdef out the sparc-specific stuff
>>  - create pdt-specific header
>> 
>> Signed-off-by: Andres Salomon <dilinger@queued.net>
> 
> Applied, thanks.  Since the difference between this version and the
> last is trivial, I've carried over davem's acked-by lines on the first
> 3 patches.
> 
> Dave, let me know if you've got any issues with this and I'll drop
> them from my tree.

No problems.
