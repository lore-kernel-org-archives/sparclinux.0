From: "David S. Miller" <davem@redhat.com>
Date: Wed, 21 Jul 2004 20:48:33 +0000
Subject: Re: [PATCH 2.6] Fix copy_user.S with gcc 3.3
Message-Id: <20040721134833.2eee0642.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1089671344.20813.28.camel@localhost.localdomain>
In-Reply-To: <1089671344.20813.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 12 Jul 2004 17:29:04 -0500
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> Jakub Jelinek helped me track down this fix, it gets sparc32 compiling
> again with gcc 3.3.*.

Applied, thanks Tom.
