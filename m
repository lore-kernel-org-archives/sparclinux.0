From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 22 Dec 2020 20:13:59 +0000
Subject: Re: sparc32: Init process fails to load with generic kmap atomic
Message-Id: <CAK8P3a1KioFh+BFpXycWhVtvaEu5qvaTLuqtw7NbYfKzCOiFsg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <c1dc2579-17b1-493b-ef23-0b9ed1ec13c3@gaisler.com>
In-Reply-To: <c1dc2579-17b1-493b-ef23-0b9ed1ec13c3@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Larsson <andreas@gaisler.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, sparclinux <sparclinux@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Dec 22, 2020 at 7:01 PM Andreas Larsson <andreas@gaisler.com> wrote:
>
> Unfortunately I did not see this problem before I encountered it in
> master. Commit 3293efa9780712ad8504689e0c296d2bd33827d5
>
...
>
> I will have to continue to dig deeper into this in January. If anyone
> has any ideas how this could stem from this kmap patch, I am all ears.

I don't immediately see it, but an easy thing to try would be to
disable CONFIG_HIGHMEM. I don't know what the limits are
on sparc, but you can often change the virtual address layout
to reserve enough space for mapping all of the physical memory,
as e.g. CONFIG_VMSPLIT_2G does on x86 or arm.

There is also some discussion about eventually removing highmem
support from the kernel entirely.

       Arnd
