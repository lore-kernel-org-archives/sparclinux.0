Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20825C433F5
	for <sparclinux@archiver.kernel.org>; Mon,  6 Sep 2021 23:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041C360698
	for <sparclinux@archiver.kernel.org>; Mon,  6 Sep 2021 23:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhIFXHa (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 19:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhIFXH3 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 6 Sep 2021 19:07:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FD1C061757
        for <sparclinux@vger.kernel.org>; Mon,  6 Sep 2021 16:06:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s12so13578486ljg.0
        for <sparclinux@vger.kernel.org>; Mon, 06 Sep 2021 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mY7a/VmEivTg4NPuZbu50Rn6Ujtyoh2UnkUiJ3azGDc=;
        b=DKgu4sQj9D3b1TJnG2x96J+Nzi9hwMBx/g/5poB/8hidxoJJPKXSLiXm0e2oRwrZvN
         8ftemzuQ+R8U8pLqvFgswLp43kBu0w/KDxGhWfzwtO9JS+Us/+/yLB4qfQYJhWGSdG1W
         Wh86pMUnWchG9rOu27J9VVu0DI0472+PlEgOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mY7a/VmEivTg4NPuZbu50Rn6Ujtyoh2UnkUiJ3azGDc=;
        b=e7ts6G5UP6zZNZ1ulun9ENYILx2A+Gf75uDVMSkIMnVihH2zst+egDdUB10JpZgt8T
         +tAs9q1LcKK6VqMoT5kvP3up97EqL7tbza9swDT1xkATiUzRczytm5ke3Z72vlfzDUVo
         v+eUw2e4sgAPnFbimAKACi62ZyWgY4krxLFPkDVo3EvSGIuoIp+CIVEltU2/8X/dJMHX
         pxDkJD8ZUZiUhRWuqgxqbfWH02zgpNiaGKsD0padEYFxArhrIi4YjICzaABsBAbJKLeo
         XOxwTdGUfwxB4d8wr6iIdpNppWRwNMfNliij2r4pUaF0PUsyk44TqOFLVqcuR1ykWyaB
         SMHg==
X-Gm-Message-State: AOAM533sDxfdgZctSzcFVJJ2Hi2E1LpOVCgL6Xbbn1LWosLhG6nOiiBO
        11KSOq0QvZDZK9gDme/Fmr+te78X7ha5waaX
X-Google-Smtp-Source: ABdhPJz4OJy0dfyUYwO+apjKxZncH3y8+WJa6LkdS5Cq4Qj22xL4UV1mLZQjWAV4B7QHdV39alXESw==
X-Received: by 2002:a2e:9b0b:: with SMTP id u11mr12399560lji.463.1630969582247;
        Mon, 06 Sep 2021 16:06:22 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v12sm842205lfi.49.2021.09.06.16.06.21
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 16:06:21 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h1so13509114ljl.9
        for <sparclinux@vger.kernel.org>; Mon, 06 Sep 2021 16:06:21 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr12180677ljn.56.1630969580644;
 Mon, 06 Sep 2021 16:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
In-Reply-To: <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Sep 2021 16:06:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
Message-ID: <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007e9f4d05cb5bb242"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

--0000000000007e9f4d05cb5bb242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Adding some subsystem maintainers ]

On Mon, Sep 6, 2021 at 10:06 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> > But hopefully most cases are just "people haven't cared enough" and
> > easily fixed.
>
> We'll see. For my testbed I disabled the new configuration flag
> for the time being because its primary focus is boot tests, and
> there won't be any boot tests if images fail to build.

Sure, reasonable.

I've checked a few of the build errors by doing the appropriate cross
compiles, and it doesn't seem bad - but it does seem like we have a
number of really pointless long-standing warnings that should have
been fixed long ago.

For example, looking at sparc64, there are several build errors due to
those warnings now being fatal:

 - drivers/gpu/drm/ttm/ttm_pool.c:386

   This is a type mismatch error. It looks like __fls() on sparc64
returns 'int'. And the ttm_pool.c code assumes it returns 'unsigned
long'.

   Oddly enough, the very line after that line does "min_t(unsigned
int" to get the types in line.

   So  the immediate reason is "sparc64 is different". But the deeper
reason seems to be that ttm_pool.c has odd type assumptions. But that
warning should have been fixed long ago, either way.

   Christian/Huang? I get the feeling that both lines in that file
should use the min_t(). Hmm?

 - drivers/input/joystick/analog.c:160

   #warning Precise timer not defined for this architecture.

   Unfortunate. I suspect that warning just has to be removed. It has
never caused anything to be fixed, it's old to the point of predating
the git history. Dmitry?

 - at least a couple of stringop-overread errors. Attached is a
possible for for one of them.

The stringop overread is odd, because another one of them is

   fs/qnx4/dir.c: In function =E2=80=98qnx4_readdir=E2=80=99:
   fs/qnx4/dir.c:51:32: error: =E2=80=98strnlen=E2=80=99 specified bound 48=
 exceeds
source size 16 [-Werror=3Dstringop-overread]
      51 |                         size =3D strnlen(de->di_fname, size);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~

but I'm not seeing why that one happens on sparc64, but not on arm64
or x86-64. There doesn't seem to be anything architecture-specific
anywhere in that area.

Funky.

Davem - attached patch compiles cleanly for me, but I'm not sure it's
necessarily the right thing to do, and I didn't check the code
generation. Maybe it screws up. Can somebody test on sparc64 and
perhaps think about it more than I did?

               Linus

--0000000000007e9f4d05cb5bb242
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kt98r8e00>
X-Attachment-Id: f_kt98r8e00

IGFyY2gvc3BhcmMva2VybmVsL21kZXNjLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gvc3BhcmMva2VybmVs
L21kZXNjLmMgYi9hcmNoL3NwYXJjL2tlcm5lbC9tZGVzYy5jCmluZGV4IDhlNjQ1ZGRhYzU4ZS4u
MzBmMTcxYjdiMDBjIDEwMDY0NAotLS0gYS9hcmNoL3NwYXJjL2tlcm5lbC9tZGVzYy5jCisrKyBi
L2FyY2gvc3BhcmMva2VybmVsL21kZXNjLmMKQEAgLTM5LDYgKzM5LDcgQEAgc3RydWN0IG1kZXNj
X2hkciB7CiAJdTMyCW5vZGVfc3o7IC8qIG5vZGUgYmxvY2sgc2l6ZSAqLwogCXUzMgluYW1lX3N6
OyAvKiBuYW1lIGJsb2NrIHNpemUgKi8KIAl1MzIJZGF0YV9zejsgLyogZGF0YSBibG9jayBzaXpl
ICovCisJY2hhcglkYXRhW107CiB9IF9fYXR0cmlidXRlX18oKGFsaWduZWQoMTYpKSk7CiAKIHN0
cnVjdCBtZGVzY19lbGVtIHsKQEAgLTYxMiw3ICs2MTMsNyBAQCBFWFBPUlRfU1lNQk9MKG1kZXNj
X2dldF9ub2RlX2luZm8pOwogCiBzdGF0aWMgc3RydWN0IG1kZXNjX2VsZW0gKm5vZGVfYmxvY2so
c3RydWN0IG1kZXNjX2hkciAqbWRlc2MpCiB7Ci0JcmV0dXJuIChzdHJ1Y3QgbWRlc2NfZWxlbSAq
KSAobWRlc2MgKyAxKTsKKwlyZXR1cm4gKHN0cnVjdCBtZGVzY19lbGVtICopIG1kZXNjLT5kYXRh
OwogfQogCiBzdGF0aWMgdm9pZCAqbmFtZV9ibG9jayhzdHJ1Y3QgbWRlc2NfaGRyICptZGVzYykK
--0000000000007e9f4d05cb5bb242--
