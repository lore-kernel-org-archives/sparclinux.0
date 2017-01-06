From: David Miller <davem@redhat.com>
Date: Fri, 06 Jan 2017 16:25:25 +0000
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data Integrity (ADI)
Message-Id: <20170106.112525.2194459503197293118.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ac86aa55-964d-56a1-1381-c208de78b24e@oracle.com>
        <f33f2c3c-4ec5-423c-5d13-a4b9ab8f7a95@linux.intel.com>
        <cae91a3b-27f2-4008-539e-153d66fc03ae@oracle.com>
In-Reply-To: <cae91a3b-27f2-4008-539e-153d66fc03ae@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khalid.aziz@oracle.com
Cc: dave.hansen@linux.intel.com, mhocko@kernel.org, rob.gardner@oracle.com, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org, hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingular

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 6 Jan 2017 09:22:13 -0700

> On 01/06/2017 08:36 AM, Dave Hansen wrote:
>> On 01/06/2017 07:32 AM, Khalid Aziz wrote:
>>> I agree with you on simplicity first. Subpage granularity is complex,
>>> but the architecture allows for subpage granularity. Maybe the right
>>> approach is to support this at page granularity first for swappable
>>> pages and then expand to subpage granularity in a subsequent patch?
>>> Pages locked in memory can already use subpage granularity with my
>>> patch.
>>
>> What do you mean by "locked in memory"?  mlock()'d memory can still be
>> migrated around and still requires "swap" ptes, for instance.
> 
> You are right. Page migration can invalidate subpage granularity even
> for locked pages. Is it possible to use cpusets to keep a task and its
> memory locked on a single node? Just wondering if there are limited
> cases where subpage granularity could work without supporting subpage
> granularity for tags in swap. It still sounds like the right thing to
> do is to get a reliable implementation in place with page size
> granularity and then add the complexity of subpage granularity.

It sounds to me, in all of this, that if the kernel manages the
movement of the pages, it thus must handle making sure the tags move
around with that page as well.

