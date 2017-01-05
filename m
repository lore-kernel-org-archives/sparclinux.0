From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 05 Jan 2017 00:05:23 +0000
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data Integrity (ADI)
Message-Id: <5a0270ea-b29a-0751-a27f-2412a8588561@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
 <6fcaab9f-40fb-fdfb-2c7e-bf21a862ab7c@linux.intel.com>
 <ae0b7d0b-54fa-fa93-3b50-d14ace1b16f5@oracle.com>
 <d234fb8b-965f-d966-46fe-965478fdf7cb@linux.intel.com>
 <8612e7db-97c5-f757-0aae-24c3acedbc29@oracle.com>
 <2c0502d0-20ef-44ac-db5b-7f651a70b978@linux.intel.com>
 <ba9c4de2-cec1-1c88-82c9-24a524eb7948@oracle.com>
 <db31d324-a1ae-7450-0e54-ad98da205773@linux.intel.com>
In-Reply-To: <db31d324-a1ae-7450-0e54-ad98da205773@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Hansen <dave.hansen@linux.intel.com>, Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kerne

On 01/04/2017 04:01 PM, Dave Hansen wrote:
> On 01/04/2017 03:58 PM, Khalid Aziz wrote:
>>> How does this all work with large pages?
>> It works with large pages the same way as normal sized pages. The TTE
>> for a large page also will have the mcd bit set in it and tags are set
>> and referenced the same way.
> But does the user setting the tags need to know what the page size is?
>
> What if two different small pages have different tags and khugepaged
> comes along and tries to collapse them?  Will the page be split if a
> user attempts to set two different tags inside two different small-page
> portions of a single THP?

The MCD tags operate at a resolution of cache lines (64 bytes). Page 
sizes don't matter except that each virtual page must have a bit set in 
its TTE to allow MCD to be enabled on the page. Any page can have many 
different tags, one for each cache line.

Rob

