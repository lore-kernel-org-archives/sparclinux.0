From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 04 Jan 2017 23:58:13 +0000
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data Integrity (ADI)
Message-Id: <ba9c4de2-cec1-1c88-82c9-24a524eb7948@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
 <6fcaab9f-40fb-fdfb-2c7e-bf21a862ab7c@linux.intel.com>
 <ae0b7d0b-54fa-fa93-3b50-d14ace1b16f5@oracle.com>
 <d234fb8b-965f-d966-46fe-965478fdf7cb@linux.intel.com>
 <8612e7db-97c5-f757-0aae-24c3acedbc29@oracle.com>
 <2c0502d0-20ef-44ac-db5b-7f651a70b978@linux.intel.com>
In-Reply-To: <2c0502d0-20ef-44ac-db5b-7f651a70b978@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Hansen <dave.hansen@linux.intel.com>, Rob Gardner <rob.gardner@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kerne

On 01/04/2017 04:49 PM, Dave Hansen wrote:
> On 01/04/2017 03:44 PM, Rob Gardner wrote:
>> On 01/04/2017 03:40 PM, Dave Hansen wrote:
>>> On 01/04/2017 03:35 PM, Rob Gardner wrote:
>>>> Tags are not cleared at all when memory is freed, but rather, lazily
>>>> (and automatically) cleared when memory is allocated.
>>> What does "allocated" mean in this context?  Physical or virtual? What
>>> does this do, for instance?
>>
>> The first time a virtual page is touched by a process after the malloc,
>> the kernel does clear_user_page() or something similar, which zeroes the
>> memory. At the same time, the memory tags are cleared.
>
> OK, so the tags can't survive a MADV_FREE.  That's definitely something
> for apps to understand that use MADV_FREE as a substitute for memset().
> It also means that tags can't be set for physically unallocated memory.
>
> Neither of those are deal killers, but it would be nice to document it.

This can go into the adi.txt doc file.

>
> How does this all work with large pages?

It works with large pages the same way as normal sized pages. The TTE 
for a large page also will have the mcd bit set in it and tags are set 
and referenced the same way.

--
Khalid



