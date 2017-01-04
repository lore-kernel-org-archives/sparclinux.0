From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 04 Jan 2017 01:22:39 +0000
Subject: Re: [PATCH v4] sparc64: Multi-page size support
Message-Id: <e9870606-812c-5efe-bc35-ea31fac303a6@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1481652247-12751-1-git-send-email-nitin.m.gupta@oracle.com>
 <20161227.123409.1061591712732030012.davem@davemloft.net>
In-Reply-To: <20161227.123409.1061591712732030012.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mike.kravetz@oracle.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, julian.calaby@gmail.com, hughd@google.com, adam.buchbinder@gmail.com, minchan@kernel.org, sfr@canb.auug.org.au, paul.gortmaker@windriver.com, thomas.tai@oracle.com, chris.hyser@oracle.com, atish.patra@oracle.com, mhocko@suse.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/27/2016 09:34 AM, David Miller wrote:
> From: Nitin Gupta <nitin.m.gupta@oracle.com>
> Date: Tue, 13 Dec 2016 10:03:18 -0800
> 
>> +static unsigned int sun4u_huge_tte_to_shift(pte_t entry)
>> +{
>> +	unsigned long tte_szbits = pte_val(entry) & _PAGE_SZALL_4V;
>> +	unsigned int shift;
>> +
>> +	switch (tte_szbits) {
>> +	case _PAGE_SZ256MB_4U:
>> +		shift = HPAGE_256MB_SHIFT;
>> +		break;
> 
> You added all the code necessary to do this on the sun4u chips that support
> 256MB TTEs, so you might as well enable it in the initialization code.
> 
> I'm pretty sure this is an UltraSPARC-IV and later feature.
> 

I added sun4u related changes just for completeness sake. I don't have
access to a sun4u machine so can't be sure if sun4u would work.
That's why that _PAGE_SZALL_4V typo escaped my notice.

I will enable setup_hugepagesz() for non-hypervisor case and send a v5.

Thanks,
Nitin
