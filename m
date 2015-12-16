From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 16 Dec 2015 00:25:42 +0000
Subject: Re: [PATCH] sparc64: Add ADI capability to cpu capabilities
Message-Id: <5670AF86.7030707@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1449097600-23288-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1449097600-23288-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12/15/2015 05:11 PM, Josip Rodin wrote:
> On Wed, Dec 02, 2015 at 04:06:40PM -0700, Khalid Aziz wrote:
>> Add ADI (Application Data Integrity) capability to cpu capabilities list.
>> ADI capability allows virtual addresses to be encoded with a tag in
>> bits 63-60. This tag serves as an access control key for the regions
>> of virtual address with ADI enabled and a key set on them. Hypervisor
>> encodes this capability as "adp" in "hwcap-list" property in machine
>> description.
>
>> +			if (strcmp(hwcaps[i], "adp") = 0)
>> +				seq_printf(m, "%sadi",
>> +					   printed ? "," : "");
>> +			else
>> +				seq_printf(m, "%s%s",
>> +					   printed ? "," : "", hwcaps[i]);
>
>> +	if (strcmp(name, "adp") = 0)
>> +		pr_cont("%sadi", (*printed) ? "," : "");
>> +	else
>> +		pr_cont("%s%s", (*printed) ? "," : "", name);
>
> Why is it necessary to change the string from adp to adi in this output?
>

adi is the externally visible name for this feature and that is how it 
is referenced in the docs. Firmware encodes it as "adp" for its internal 
use and that is how it shows up in hwcap-list property. So this code 
translates it from firmware internal name to the external name which 
would make sense to someone looking at /proc/cpuinfo.

Thanks,
Khalid
