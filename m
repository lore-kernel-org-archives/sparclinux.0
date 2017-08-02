From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 02 Aug 2017 05:01:23 +0000
Subject: Re: [mmotm:master 50/189] include/linux/swapops.h:220:9: error: implicit declaration of function '__
Message-Id: <20170802050123.GA23155@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <201708011949.LtRajyO5%fengguang.wu@intel.com>
 <20170801143853.f210976a43d009dba1eeb0db@linux-foundation.org>
 <3B5D0C56-FCBC-4911-9BE8-9CA895CBE49F@cs.rutgers.edu>
In-Reply-To: <3B5D0C56-FCBC-4911-9BE8-9CA895CBE49F@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Linux Memory Management List <linux-mm@kvack.org>, sparclinux@vger.kernel.org

Hi Yan Zin.
> 
> I saw __pmd() was deleted at commit 6e6e41879: sparc32: fix build with STRICT_MM_TYPECHECKS.
> It was commented out at least since 2008, before commit a439fe51a.
> 
> Is there any way to bring it back? Since __pmd() can help us work around a GCC zero initializer bug.

Just send a patch to sparclinux, with a proper commit message
that captures the details why it is required.

Please do not wait for me to do it, as that may take a few days
since I have not looked up all the history why it is needed.

In other words, the code change is trivial, it will more
time to explain *why* it is re-introduced.

	Sam
