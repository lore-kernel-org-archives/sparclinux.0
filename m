From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 07 Jun 2019 20:10:51 +0000
Subject: Re: [PATCH v2] uaccess: add noop untagged_addr definition
Message-Id: <CAHk-=wjKy5503vYoj3ZizGz69iBos69wdrEujojuri67vV=BVQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
In-Reply-To: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Konovalov <andreyknvl@google.com>, Christoph Hellwig <hch@lst.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>, sparclinux@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dmitry Vyukov <dvyukov@google.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Kostya Serebryany <kcc@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yishai Hadas <yishaih@mellanox.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, Lee Smith <Lee.Smith@arm.com>, Alexander Deucher <Alexander.Deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>, Christian Koenig <Christian.Koenig@amd.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Tue, Jun 4, 2019 at 5:04 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Architectures that support memory tagging have a need to perform untagging
> (stripping the tag) in various parts of the kernel. This patch adds an
> untagged_addr() macro, which is defined as noop for architectures that do
> not support memory tagging.

Ok, applied directly to my tree so that people can use this
independently starting with rc4 (which I might release tomorrow rather
than Sunday because I have some travel).

                  Linus
