From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Date: Tue, 16 Apr 2013 21:37:14 +0000
Subject: Re: [PATCH 03/28] proc: Split kcore bits from linux/procfs.h into linux/kcore.h [RFC]
Message-Id: <CAHGf_=r+qoL8_J+z8Y1uPt_NK1Ef4cLuapAvVd-7qF8+_oSjJw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130416182550.27773.89310.stgit@warthog.procyon.org.uk> <20130416182601.27773.46395.stgit@warthog.procyon.org.uk>
In-Reply-To: <20130416182601.27773.46395.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, "linux-mm@kvack.org" <linux-mm@kvack.org>, x86@kernel.org, sparclinux@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

On Tue, Apr 16, 2013 at 11:26 AM, David Howells <dhowells@redhat.com> wrote:
> Split kcore bits from linux/procfs.h into linux/kcore.h.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-mips@linux-mips.org
> cc: sparclinux@vger.kernel.org
> cc: x86@kernel.org
> cc: linux-mm@kvack.org

I have no seen any issue in this change. but why? Is there any
motivation rather than cleanup?
