Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EC5C433FE
	for <sparclinux@archiver.kernel.org>; Tue, 26 Oct 2021 08:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A830A60527
	for <sparclinux@archiver.kernel.org>; Tue, 26 Oct 2021 08:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhJZIRD convert rfc822-to-8bit (ORCPT
        <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:17:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhJZIRC (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 26 Oct 2021 04:17:02 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MsZBb-1myBKY0QI7-00tzsY; Tue, 26 Oct 2021 10:14:37 +0200
Received: by mail-wm1-f41.google.com with SMTP id j2-20020a1c2302000000b0032ca9b0a057so1313645wmj.3;
        Tue, 26 Oct 2021 01:14:36 -0700 (PDT)
X-Gm-Message-State: AOAM530HFpbmx0M5xFRRNg222kDCtTJXEdfWMWGM5BlXvFtVE8LE7jdp
        yzLEi9XxyHFJI5UBkCtkcNz1vQWtDBStTyvIkb4=
X-Google-Smtp-Source: ABdhPJwxpyDihyUqL4uFyUbZysPYeSEn9UV7W6yiXZ0Tf3UTjf7qxT/vxk6HTOzYZCTvSrEZWD+SqTwJCKRRzsEy/xE=
X-Received: by 2002:a7b:ce93:: with SMTP id q19mr12919303wmj.98.1635236076761;
 Tue, 26 Oct 2021 01:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211026080426.2444756-1-geert@linux-m68k.org>
In-Reply-To: <20211026080426.2444756-1-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Oct 2021 10:14:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3hfQpOh5WJpE+xL-gcp6mpZHOJeJThzzjSp_tnKh2q2g@mail.gmail.com>
Message-ID: <CAK8P3a3hfQpOh5WJpE+xL-gcp6mpZHOJeJThzzjSp_tnKh2q2g@mail.gmail.com>
Subject: Re: [PATCH] serial: sunzilog: Mark sunzilog_putchar() __maybe_unused
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Y+CwRgjyeQBogGWSkDvxqsVljVLX9QxJVNKPcuv+Ix9iSTmiHi3
 Jo+AO2IEXN5FNeg9w2j/hqsb0o90IN7WHPoGUmD1x8jz1tGz1GGUVQeppE544lBx5A9AIFH
 7msXzCQWhKY9bgL2696NB3JFs1Vpvs/f4p1T8VN07Uu+5/L4j35WhEsLhlZXWf5mWs78N6o
 s4SjNf4kQTUI/M7DuFl1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CxuRPf8P+Is=:tbS/bu8I+kxkPusiSYjyJc
 gTKVr+J06XEEUuonQZ9bv3pPsJNJxYq8X/HS0abpa+LRaQsqggZOmMhU7wrVQ0SxVuX5gQfPw
 9b2cex5s4Z5+O4DkVu3EwZfjeZ6eI2NaydF8Nz0mrRNcracrO2Amug2zFzxhjwAJZc5xMDcrp
 B0buwQWtnWueTOzjObSR3SLw52LTz1/CrKlvJWO4U4JSoDP+NY9rmzq5kGg7dKLNk633w+wEY
 DuoL8V3icUav36197erovnRfqdCEJ4wWZ/bJol7cUXMQwlvXmqSVbBuAmuKr/B9sDHjK8KT7m
 7JY+MO2Cc/8pUNYMtA2yibWqWJckmah7IapD3alYSlPx1xjGzeGBZZb/OPwyLZB9R+cUaDFmr
 Avq9p0ZnNw3HcfNxOvkqOwWhp6sn7BWJLXhMrMG2S8BMbyhmLbTTOT0H/gXyG7TaUvgo1tsvE
 PGPzHJSOV/e3oYtXOC/v2ZFgeE1ji+noxW0pzIh6IF3EyW/wAKQgWqO+tCOMeIBJHRNfHX8TG
 pKTBPusIYQGG5RJlZKsxmDAeheJY1ojpoXNOOKO5BrmbIXyhQEemAcGaoZ3lkN2Le6onptaNK
 6niFuQvBHpHBHW1zfwwk3fMfWhXthpcjHB6m8B0ekUPMSPU8pgHDKhHfLmBqblpVqWV0LmBH4
 IzDOfJ2QKyzt71sDHWnm7a8pqxEKjEkjOCTneTi+9R4SAEYkDp/Pxwzp30AKREDBjw6c=
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Oct 26, 2021 at 10:04 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> If CONSOLE_POLL=n, CONFIG_SERIAL_SUNZILOG_CONSOLE=n, and CONFIG_SERIO=m:
>
>     drivers/tty/serial/sunzilog.c:1128:13: error: ‘sunzilog_putchar’ defined but not used [-Werror=unused-function]
>      1128 | static void sunzilog_putchar(struct uart_port *port, int ch)
>           |             ^~~~~~~~~~~~~~~~
>
> Fix this by marking sunzilog_putchar() __maybe_unused.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks good to me

Acked-by: Arnd Bergmann <arnd@arndb.de>
