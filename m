From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Sat, 29 Jul 2017 02:46:13 +0000
Subject: Re: [PATCH v3] sparc64: Increase max_phys_bits to 51 and VA bits to 53 for M8.
Message-Id: <27a7fc1c-860f-c229-f4a5-8ef8c2aacf2d@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501291772-470855-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1501291772-470855-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 7/28/2017 9:13 PM, Greg Onufer wrote:
> On Fri, Jul 28, 2017 at 6:29 PM, Vijay Kumar<vijay.ac.kumar@oracle.com>  wrote:
>> +               case SUN4V_CHIP_SPARC_M8:
>> +               default:
>> +                       /* M8 and later support 54-bit virtual addresses.
>> +                        * However, restricting M8 and above VA bits to 53
>> +                        * as 4-level page table cannot support more than
>> +                        * 53 VA bits.
>> +                        */
>> +                       sparc64_va_hole_top =    0xfff0000000000000UL;
>> +                       sparc64_va_hole_bottom = 0x0010000000000000UL;
>> +                       max_phys_bits = 51;
>> +                       break;
>>                  }
>>          }
> 
> These values are supposed to be initialized from MD/OBP properties,
> not hard-coded based on the CPU type.  Then you won't need to add more
> cases every time.

Agree. Currently these bits are hard coded for all the CPU types. This 
needs to be changed in future.

Thanks,
Vijay
