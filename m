From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 09 Mar 2021 14:52:15 +0000
Subject: Re: [PATCH] sparc64: Fix opcode filtering in handling of no fault loads
Message-Id: <CADxRZqybON2s+_BWx4LzruuR8dsshiLC=9PcPZ4Svi22Kf3eJg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1614577696-27586-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1614577696-27586-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 1, 2021 at 7:03 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> On Mon, Mar 1, 2021 at 9:09 AM Rob Gardner <rob.gardner@oracle.com> wrote:
> >
> > is_no_fault_exception() has two bugs which were discovered via random
> > opcode testing with stress-ng. Both are caused by improper filtering
> > of opcodes.
>
> fixes the issue for me. thanks again
>
> Tested-by: Anatoly Pugachev <matorola@gmail.com>

Rob,

you might want to add:

Fixes: b6fe1089667a7afcc2cf92cdaec590c7b8381715

as well , on a patch submission.
