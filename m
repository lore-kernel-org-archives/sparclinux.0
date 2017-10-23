From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 23 Oct 2017 15:19:20 +0000
Subject: Re: [PATCH] sparc64: convert mdesc_handle.refcnt from atomic_t to refcount_t
Message-Id: <2331cc3d-7a89-a835-bfc2-cab1dd2df9c3@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1508486277-24913-1-git-send-email-elena.reshetova@intel.com>
 <519f48f1-3145-6bf4-469f-0c6059681287@oracle.com>
 <2236FBA76BA1254E88B949DDB74E612B802B4255@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B802B4255@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Reshetova, Elena" <elena.reshetova@intel.com>, "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "jag.raman@oracle.com" <jag.raman@oracle.com>, "peterz@infradead.org" <peterz@infradead.org>, "keescook@chromium.org" <keescook@chromium.org>

On 10/23/2017 12:10 AM, Reshetova, Elena wrote:
>> On 10/20/2017 12:57 AM, Elena Reshetova wrote:
>>> atomic_t variables are currently used to implement reference
>>> counters with the following properties:
>>>    - counter is initialized to 1 using atomic_set()
>>>    - a resource is freed upon counter reaching zero
>>>    - once counter reaches zero, its further
>>>      increments aren't allowed
>>>    - counter schema uses basic atomic operations
>>>      (set, inc, inc_not_zero, dec_and_test, etc.)
>>>
>>> Such atomic variables should be converted to a newly provided
>>> refcount_t type and API that prevents accidental counter overflows
>>> and underflows. This is important since overflows and underflows
>>> can lead to use-after-free situation and be exploitable.
>>>
>>> The variable mdesc_handle.refcnt is used as pure reference counter.
>>> Convert it to refcount_t and fix up the operations.
>>>
>>> Suggested-by: Kees Cook <keescook@chromium.org>
>>> Reviewed-by: David Windsor <dwindsor@gmail.com>
>>> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
>>> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>>
>> Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
> 
> Thank you Shannon! Would you be able to take this patch into the respective tree
> to propagate normally from there?
> 
> Best Regards,
> Elena.

Hi Elena,

Dave Miller takes good care of the sparclinux tree, I'm sure this is on 
his ToDo list already.

sln

