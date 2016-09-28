From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 28 Sep 2016 20:51:40 +0000
Subject: Re: [PATCH v3 1/2] config: Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL for sparc
Message-Id: <20160928205140.GA1750@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
 <1475004808-91920-2-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1475004808-91920-2-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, Sep 27, 2016 at 12:33:27PM -0700, Babu Moger wrote:
> This new config parameter limits the space used for "Lock debugging:
> prove locking correctness" by about 4MB. The current sparc systems have
> the limitation of 32MB size for kernel size including .text, .data and
> .bss sections. With PROVE_LOCKING feature, the kernel size could grow
> beyond this limit and causing system boot-up issues. With this option,
> kernel limits the size of the entries of lock_chains, stack_trace etc.,
> so that kernel fits in required size limit. This is not visible to user
> and only used for sparc.
> 
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
