From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Nov 2019 19:18:12 +0000
Subject: Re: [PATCH 8/8] Input: input_event: fix struct padding on sparc64
Message-Id: <CAK8P3a1coj4GpwcCgL0rEvZKb4OvktopjRETCNWEwfaLxgbcHQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191108203435.112759-1-arnd@arndb.de> <20191108203435.112759-9-arnd@arndb.de>
 <20191111182828.GC57214@dtor-ws>
In-Reply-To: <20191111182828.GC57214@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "# 3.4.x" <stable@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Mon, Nov 11, 2019 at 7:28 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> I do not like ifdefs here, do you think we could write:
>
>                 client->buffer[client->tail] = (struct input_event) {
>                         .input_event_sec = event->input_event_sec,
>                         .input_event_usec = event->input_event_usec,
>                         .type = EV_SYN,
>                         .code = SYN_DROPPED,
>                 };
>
> to ensure all padded fields are initialized? This is not hot path as we
> do not expect queue to overfill too often.

Good idea, changed both instances now. Thanks for taking a look!

      Arnd
