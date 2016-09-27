From: Babu Moger <babu.moger@oracle.com>
Date: Tue, 27 Sep 2016 14:51:40 +0000
Subject: Re: [PATCH v2 1/2] config: Add new CONFIG_PROVE_LOCKING_SMALL
Message-Id: <a46631c4-a25f-88b7-9ab5-5e6733c63f51@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1474929098-68914-1-git-send-email-babu.moger@oracle.com>
 <1474929098-68914-2-git-send-email-babu.moger@oracle.com>
 <20160927044625.GA13264@ravnborg.org>
 <20160927114009.GM5016@twins.programming.kicks-ass.net>
In-Reply-To: <20160927114009.GM5016@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


On 9/27/2016 6:40 AM, Peter Zijlstra wrote:
> On Tue, Sep 27, 2016 at 06:46:25AM +0200, Sam Ravnborg wrote:
>> Since this is only relevant for sparc, and for sparc this is "select"ed,
>> then there is limited/no gain having this as a visible menu config option.
>>
>> How about adding just a simple non-visible config symbol:
>>
>> config PROVE_LOCKING_SMALL
>> 	bool
>>
>> The nice help text can be added to the H file, and the select
>> can be move to the sparc/Kconfig file where it really belongs.
> Yes, this should not be user selectable. I don't mind the help being
> here though.
  How about this?
  Moved everything to arch/sparc/Kconfig.debug. It may be not useful to 
have help in
config file as it is not visible. Lets have some explanation in .h file.
I will send v3 version if you all agree.
==================diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 6db35fb..67e58a1 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -21,4 +21,9 @@ config FRAME_POINTER
         depends on MCOUNT
         default y

+config PROVE_LOCKING_SMALL
+       bool
+       depends on PROVE_LOCKING && SPARC
+       default y
+
  endmenu

