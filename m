Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3F476CD8
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817089; cv=pass; b=NfKMxq4VFv1ul8RZKI99a19k3/OIIFrxiVmHVV16DAy9I7cA0fpRTA2fzJcrUAWzQAM39HoY8GIC9yyBF0N37OfRecBgkNL4aHUNp8s+pnE1MODhwQF9UmbMufgNQ8yk1hCTTVQ9oy+iyI2YrdX3N6JSKj4wHjUmjyCBLRCB5a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817089; c=relaxed/simple;
	bh=PDf9PTevrU3TjKRVfHzJfhuumh3qViGjZMfENWQXMFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mchDQx2msV65HdLuGTBFcUTCAM3rLvQfWhEkABFbnn4+vI8Gmza9yD+fEGU13zhqLfhtb7iweKGbXF3RTCzCIKQdv0MNMfZcMg4aA5vLPSG5dS6hWGoQDjYPlszjnWAKebAG/fX1vecDUuZdkPOuI0dDo8bviBQWEQxlHW+qIsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laybEXyy; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laybEXyy"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso337916066b.2
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 07:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791817086; cv=none;
        d=google.com; s=arc-20260327;
        b=Yggigup+XnzKOpu6dYOJGmOwNA6qQeAe4l6BgNG+fSUJElY0kJbrVn0zAz8QcNyN7Y
         QN4Pe/LQEAPxIrrh3Z9ayUxn/JD7kFL8zWe3odvczT/gvUfUpAxNZHkIEIR1B1w1C/Db
         GpCQyQw8199566FQ5q2KNW6uaOIjDmM2rM6g5RW5ZJhqUfzLqq2hoLCQQj37fLU9JJk1
         5s3+wrmEJu76m9cbtmpeliUzNTN3BJ1b45iC2awXuh4Khkczt+M/O33rmb9wDxJy4264
         narWTlOcFDYYgzCi1Ivw7GFtdWK/TxEMpRlsi68yqBcqw8Xy/tqFaMzJoB8N4gqBd3pT
         6TZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JVTRT0r/ReMiMwgJ0HrEGwYjTwBmKMQXnUxQbyPr24M=;
        fh=LWywF/n3nlD401vktJrdC71YXMyNChRVvqlDLPQym6E=;
        b=qi/F1BnfUpLvHP2VyygjzELXPHqFz6bOmdYZO1gdwBBeSOnUqIT5AOBcHvv0d1wvfW
         p8RyqzSk5GQR5ZeFR9tF2BtVR/uom3PvXJhZYXRCb5440CIUZ/TCfuPZhoEVMr3rki3O
         L/ba8v48CpsO5/nXLYxJZp1A4JGbznDqAdGNfStcrLLArPenRWRHN0eQ8xj9+Z5eHyIP
         EpBZ8X2/z9pUoRXxX7UpLZ8Dj3vmiLP7Pnv0wPQzlEIJxb97hbK93wBKD1dHHi/DM9L2
         73TR+O5fhPJxHwns2g7RmQS0b9Hn9kf7JgCAje6E5zhXXEONeWeds2D7EhOf9ARt3g2+
         gXZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817086; x=1792421886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JVTRT0r/ReMiMwgJ0HrEGwYjTwBmKMQXnUxQbyPr24M=;
        b=laybEXyyBTwCM6IpiSv1O81picH6CIXJBWyy4Q7iHgjnDad97TP23qTjQyqcrLWOR+
         ojKWVFr2IrsxLnVLzfJ9wblfQKqXAcgLuRKt2rhlTntj+9boVqXQ8v3i3zr8BY144KXY
         J0h22PmfOEbsqISRai5ib7EDBQwKnK435fK7JWGZ9kKegpfd4OAQ/kcwvmFrUjtUpIBV
         O48a7TJXeGc9K3fs9/I5eDUvFCHV72wi60qrUfyA2bpqbLDuQlV8ZVJRB8V7UtDCR4qM
         VeUXel6ziHGqSVnqG/XRAXMf4SPviNsqqh/QYS9prC9KPVZ9y5w3GwCDvf3sKHOOnePC
         c6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817086; x=1792421886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JVTRT0r/ReMiMwgJ0HrEGwYjTwBmKMQXnUxQbyPr24M=;
        b=s5tvAqkavmvTdYG2BCbnPn2k8u2twH2AugskRogMNc1EpNPAYe5XFi9GJIQ7EBrJ8W
         nopkU5n4HKB0cmJV4UXgWAldLRb4tZo4/Z4Av83pYtFlG+FvKgdt+nm8uGnTJK5W2JQx
         NfBZi1zlbOuE+huvim4ECj9Rt5p4AskW2UptvZZ73QnTwMfjlmDl6JJWYuRNp5XrJJCe
         CZpY4gWrc4xZPO/fj+eOWQnbdahnShXqmWbsIClh/gqM0yoYVE4ZOkZuL9Y1SE13Zp3F
         d7xn5VBzUJfNf3nHljX94ao60bLMBrIYowOn9alXD8iDcunRedqsy7BjOHvGEdF0kgvJ
         Q7AQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYok+oFOAwwj3ypXVtCnIrPkqD3rCNawl2HcF0kUurcXhCKvypei9IpWIl+09EM17A0C2/NkmNLFQ9@vger.kernel.org
X-Gm-Message-State: AFq9FYKZV3TUpSVttMU8PK18Y1WYZ6CYenxN4/SdAll5kwQblgCOcGGq
	Pb6e5KDz+WFH56bSFGSNmt1wfpUO4E+JMwwrlO4C2851h5gAxxuiVFdTjat5IShpln8xpw1/x8Z
	K7QgSRuoUOBWQ/GFLGgQM9/MXsJe1TJg=
X-Gm-Gg: AYBFou3G9d/g59Ol+NrDdMFWDhG+jWaMfUEw63jhbFDpybzg+ttOB2qBBReYvz9hjy1
	SKZzyPxnz9vL6jajy2J/ZWyrwAuBCIZnWB+zZPkBECW7fXRcZLlIdUwGvpHn29Y/HambuT+9QYy
	cWmqNod+VLuWZQ8n6fpHPxkBMaZbxUYmeG5OPnJYSnfCJ6PL93j/thP+qERkh0U6E/F0GlLUKLJ
	cp33qVW0ELMJX9qaArdErQS1EW2vDRdKafa4ZxMGWnEg++miLfmxk85g3gkndB795Ds5C7/SXi6
	97PMu5PUklZQKb7SCMM+Q1fk26m7vYhgHGzmvYvxvh8+iMOlc0jiucA3flMXqRVpURwYTuGyiYI
	bajTkGA//BbKOU9o049jGB9vvo8Bjk1m64wcXdKs9bw==
X-Received: by 2002:a17:906:4790:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c31a9a10e7fmr977505266b.3.1791817085896; Mon, 12 Oct 2026
 07:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011195729.981243-1-linmag7@gmail.com> <20261011195729.981243-7-linmag7@gmail.com>
 <1f66c850-faa7-477f-9535-761074ccc077@kernel.org>
In-Reply-To: <1f66c850-faa7-477f-9535-761074ccc077@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 16:57:54 +0200
X-Gm-Features: AclHuK_IcZyjHiUIK3u3hTnPLckXjpGLARIbdXHePuP-SPEHyVHxb2JKX2D2wsY
Message-ID: <CA+=Fv5STgFEmKU7V7rAE1-CSCnYHN8e=TA=mNDT8Wp_HBZzu+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] hvc: add an M3000 firmware console backend
To: Jiri Slaby <jirislaby@kernel.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, krzk@kernel.org, 
	oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Mon, Oct 12, 2026 at 8:46=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 11. 10. 26, 21:55, Magnus Lindholm wrote:
> ...
> > --- /dev/null
> > +++ b/drivers/tty/hvc/hvc_m3000.c
> > @@ -0,0 +1,205 @@
>
> > +struct m3000_console {
> > +     int stdin;
> > +     bool ready;
> > +     u8 buffer[256];
> > +     raw_spinlock_t buffer_lock;
> > +     struct timer_list poll_timer;
> > +     struct mutex poll_mutex; /* Serialize open against synchronous cl=
ose. */
> > +     spinlock_t poll_lock; /* Protect active state and timer rearming.=
 */
> > +     bool poll_active;
>
> Perhaps group these a bit better, so that there are not such holes?
>

Done for v3. Reordering the members reduced the structure from 344
to 336 bytes with the tested configuration.

> > +};
> ...
> > +/*
> > + * HVC's idle backoff can exceed the firmware input FIFO's capacity.
> > + * Wake its worker each tick while open; keep PROM calls out of the ti=
mer.
> > + */
> > +static void m3000_poll_tick(struct timer_list *timer)
> > +{
> > +     struct m3000_console *con =3D timer_container_of(con, timer, poll=
_timer);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&con->poll_lock, flags);
>
> Any reason not to use guard()s?
>

No particular reason. I've switched this to guard(spinlock_irqsave).

> > +     if (con->poll_active) {
> > +             hvc_kick();
> > +             mod_timer(&con->poll_timer, jiffies + 1);
> > +     }
> > +     spin_unlock_irqrestore(&con->poll_lock, flags);
> > +}
> > +
> > +static int m3000_open(struct hvc_struct *hp, int data)
> > +{
> > +     struct m3000_console *con =3D m3000_console(hp->vtermno);
> > +     unsigned long flags;
> > +
> > +     if (!con)
> > +             return -ENODEV;
> > +     mutex_lock(&con->poll_mutex);
> > +     spin_lock_irqsave(&con->poll_lock, flags);
>
> Same here.
>

Done, using guards for both locks, preserving their acquisition and
release order.

> > +     con->poll_active =3D true;
> > +     mod_timer(&con->poll_timer, jiffies + 1);
> > +     spin_unlock_irqrestore(&con->poll_lock, flags);
> > +     mutex_unlock(&con->poll_mutex);
> > +     return 0;
> > +}
> > +
> > +static void m3000_close(struct hvc_struct *hp, int data)
> > +{
> > +     struct m3000_console *con =3D m3000_console(hp->vtermno);
> > +     unsigned long flags;
> > +
> > +     if (!con)
> > +             return;
> > +     mutex_lock(&con->poll_mutex);
> > +     spin_lock_irqsave(&con->poll_lock, flags);
>
> And here.
>

Done, using guard(mutex) and a scoped spinlock guard. The spinlock is
released before timer_delete_sync(), while the mutex remains held.

> > +     con->poll_active =3D false;
> > +     spin_unlock_irqrestore(&con->poll_lock, flags);
> > +     /* Block reopen until the callback has finished and cannot rearm.=
 */
> > +     timer_delete_sync(&con->poll_timer);
> > +     mutex_unlock(&con->poll_mutex);
> > +}
> > +
> > +static ssize_t m3000_io(struct m3000_console *con, u8 *in,
> > +                     const u8 *out, size_t count)
> > +{
> > +     unsigned long args[7], flags;
> > +     bool input =3D in;
>
> You can test "in" below directly, right?
>

Yes, I've removed the boolean and now test "in" directly.

> > +     int ret;
> > +
> > +     if (!count)
> > +             return 0;
> > +     count =3D min(count, input ? 1 : sizeof(con->buffer));
> > +     /* Console writes can run with interrupts disabled; this lock can=
not sleep. */
> > +     raw_spin_lock_irqsave(&con->buffer_lock, flags);
>
> scoped_guard()
>

Done for v3. Reordering the members reduced the structure from 344
to 336 bytes with the tested configuration.

> > +     if (!input)
> > +             memcpy(con->buffer, out, count);
> > +     args[0] =3D (unsigned long)(input ? "read" : "write");
> > +     args[1] =3D 3;
> > +     args[2] =3D 1;
> > +     args[3] =3D (unsigned int)(input ? con->stdin : prom_stdout);
> > +     args[4] =3D (unsigned long)con->buffer;
> > +     args[5] =3D count;
> > +     args[6] =3D (unsigned long)-1;
> > +     p1275_cmd_direct(args);
> > +     ret =3D (int)args[6];
> > +     if (ret > 0 && ret <=3D count && input)
> > +             memcpy(in, con->buffer, ret);
> > +     raw_spin_unlock_irqrestore(&con->buffer_lock, flags);
> > +     if (ret =3D=3D -2 || ret =3D=3D 0)
>
> That's full of magic constants. Can we have defines for those?
>

I've added defines for the firmware argument/return counts and the
-1/-2 status values. I've kept zero literal as a zero-byte result.

> > +             return 0;
> > +     if (ret < 0 || ret > count)
> > +             return -EIO;
> > +     return ret;
> thanks,
> --
> js
> suse labs

Both GCC and Clang W=3D1 builds completed, and the GCC-built kernel
passed boot and HVC input/output, open/close, and hangup/reopen tests
on the M3000.

I'll put out the v3 asap

Regards,
Magnus
