From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Feb 2013 22:39:07 +0000
Subject: Re: [PATCH] of: fix recursive locking in of_get_next_available_child()
Message-Id: <20130211223907.271653E3530@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <1360617332-2738-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1360617332-2738-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <rob.herring@calxeda.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Gleixner <tglx@linutronix.de>, linux-rt-users@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, linux-next@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

On Mon, 11 Feb 2013 14:15:32 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> of_get_next_available_child() acquires devtree_lock, then calls
> of_device_is_available() which calls of_get_property() which calls
> of_find_property() which tries to re-acquire devtree_lock, thus causing
> deadlock.
> 
> To avoid this, create a new __of_device_is_available() which calls
> __of_get_property() instead, which calls __of_find_property(), which
> does not take the lock,. Update of_get_next_available_child() to call
> the new __of_device_is_available() since it already owns the lock.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks for looking at this Stephen. I ended up applying my version of
this patch though just because it was more convenient to do so. It was
pretty much identical anyway.

g.
