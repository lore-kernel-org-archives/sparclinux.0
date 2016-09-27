From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 27 Sep 2016 11:40:09 +0000
Subject: Re: [PATCH v2 1/2] config: Add new CONFIG_PROVE_LOCKING_SMALL
Message-Id: <20160927114009.GM5016@twins.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1474929098-68914-1-git-send-email-babu.moger@oracle.com>
 <1474929098-68914-2-git-send-email-babu.moger@oracle.com>
 <20160927044625.GA13264@ravnborg.org>
In-Reply-To: <20160927044625.GA13264@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Babu Moger <babu.moger@oracle.com>, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, Sep 27, 2016 at 06:46:25AM +0200, Sam Ravnborg wrote:
> Since this is only relevant for sparc, and for sparc this is "select"ed,
> then there is limited/no gain having this as a visible menu config option.
> 
> How about adding just a simple non-visible config symbol:
> 
> config PROVE_LOCKING_SMALL
> 	bool
> 
> The nice help text can be added to the H file, and the select
> can be move to the sparc/Kconfig file where it really belongs.

Yes, this should not be user selectable. I don't mind the help being
here though.
