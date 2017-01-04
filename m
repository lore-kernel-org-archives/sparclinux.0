From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 04 Jan 2017 23:46:52 +0000
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data Integrity (ADI)
Message-Id: <f58e46c2-5ae6-8cff-3fde-f9ee1729fd71@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
 <f7985965-3e33-4352-0ffb-97a5407f7acc@linux.intel.com>
In-Reply-To: <f7985965-3e33-4352-0ffb-97a5407f7acc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Hansen <dave.hansen@linux.intel.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kerne

On 01/04/2017 04:31 PM, Dave Hansen wrote:
> One other high-level comment:  It would be nice to see the
> arch-independent and x86 portions broken out and explained in their own
> right, even if they're small patches.  It's a bit cruel to make us
> scroll through a thousand lines of sparc code to see the bits
> interesting to us.

Sure, that is very reasonable. I will do that.

>
> It would also be really nice to see a high-level breakdown explaining
> what you had to modify, especially since this affects all of the system
> calls that take a PROT_* argument.  The sample code is nice, but it's no
> substitute for writing it down.

I will expand the explanation in Documentation/sparc/adi.txt.

Thanks!

--
Khalid
