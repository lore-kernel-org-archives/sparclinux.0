From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 06 Jan 2017 17:10:09 +0000
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data Integrity (ADI)
Message-Id: <dd42d787-0d3c-bd91-7376-3ce35bdd4c4c@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <f33f2c3c-4ec5-423c-5d13-a4b9ab8f7a95@linux.intel.com>
 <cae91a3b-27f2-4008-539e-153d66fc03ae@oracle.com>
 <b761e7a9-6f64-e8cb-334a-a49528e95cdf@linux.intel.com>
 <20170106.120204.927644401352332269.davem@davemloft.net>
In-Reply-To: <20170106.120204.927644401352332269.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, dave.hansen@linux.intel.com
Cc: mhocko@kernel.org, rob.gardner@oracle.com, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org, hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hann

On 01/06/2017 10:02 AM, David Miller wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> Date: Fri, 6 Jan 2017 08:55:03 -0800
>
>> Actually, that reminds me...  How does your code interface with ksm?  Or
>> is there no interaction needed since you're always working on virtual
>> addresses?
>
> This reminds me, I consider this feature potentially extremely useful for
> kernel debugging.  So I would like to make sure we don't implement anything
> in a way which would preclude that in the long term.

I agree and please do point out if I have made any implementation 
decisions that could preclude that.

Thanks,
Khalid

