From: "David S. Miller" <davem@redhat.com>
Date: Sun, 28 Mar 2004 09:16:24 +0000
Subject: Re: Another compile problem on sparc64
Message-Id: <20040328011624.442bf391.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1080384189.2285.8.camel@pegasus>
In-Reply-To: <1080384189.2285.8.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


You could have killed all of this by just temporarily removing
the "-Werror" that gets added in the arch/sparc64/ Makefiles :-)

This latest one only happens on uniprocessor builds, which is why
I didn't catch it.  Only recent debian unstable updates of gcc started
to emit these warnings fwiw...

Anyways, here's the fix, I'll push it off to Linus.

=== arch/sparc64/mm/init.c 1.55 vs edited ==--- 1.55/arch/sparc64/mm/init.c	Mon Mar  1 06:30:54 2004
+++ edited/arch/sparc64/mm/init.c	Sun Mar 28 01:13:58 2004
@@ -104,7 +104,7 @@
                                 if (page2)
                                         page2->lru.next = page->lru.next;
                                 else
-                                        (struct page *)pgd_quicklist = page->lru.next;
+                                        pgd_quicklist = (void *) page->lru.next;
                                 pgd_cache_size -= 2;
                                 __free_page(page);
                                 if (page2)
