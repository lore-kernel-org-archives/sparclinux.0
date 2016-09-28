From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 28 Sep 2016 20:51:54 +0000
Subject: Re: [PATCH v3 2/2] lockdep: Limit static allocations if PROVE_LOCKING_SMALL is defined
Message-Id: <20160928205154.GB1750@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
 <1475004808-91920-3-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1475004808-91920-3-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, Sep 27, 2016 at 12:33:28PM -0700, Babu Moger wrote:
> Reduce the size of data structure for lockdep entries by half if
> PROVE_LOCKING_SMALL if defined. This is used only for sparc.
> 
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
