From: David Howells <dhowells@redhat.com>
Date: Tue, 16 Apr 2013 22:07:37 +0000
Subject: Re: [PATCH 03/28] proc: Split kcore bits from linux/procfs.h into linux/kcore.h [RFC]
Message-Id: <30949.1366150057@warthog.procyon.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <CAHGf_=r+qoL8_J+z8Y1uPt_NK1Ef4cLuapAvVd-7qF8+_oSjJw@mail.gmail.com> <20130416182550.27773.89310.stgit@warthog.procyon.org.uk> <20130416182601.27773.46395.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAHGf_=r+qoL8_J+z8Y1uPt_NK1Ef4cLuapAvVd-7qF8+_oSjJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Cc: dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, "linux-mm@kvack.org" <linux-mm@kvack.org>, x86@kernel.org, sparclinux@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>


KOSAKI Motohiro <kosaki.motohiro@gmail.com> wrote:

> I have no seen any issue in this change. but why? Is there any
> motivation rather than cleanup?

Stopping stuff mucking about with the internals of procfs incorrectly
(sometimes because the internals of procfs have changed, but the drivers
haven't).

David
