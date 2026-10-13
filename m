Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD943C10A3
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900627; cv=pass; b=rPJQyTUeB6fL9yIsUZJg4CzauWbO4lGiLyP8KVMRIaTioJp46I+PLpLcGffaWI8fEob5xNKKpYnN6umk/VFcPlBWGn38fRk4STSHyGU9fDSWOjk0GNOVNioVEOtj+uLgN0bGEjYZ9QIu2xr0RWIAwP2O3ZMhCt5ztdhvgWb/Hds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900627; c=relaxed/simple;
	bh=4CMVjLZ9yf45K7jKpjiX1QDRl6WTF88sgG9+iYuBnks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVhIJcZmCpr14OeEuOxX7xzSMmLraVbTFdijtyAYrxGtetABGTKeM2Pju8IEpwfQrkQGXbxR+wcVIxBGPtWrvjoLQdRnBXNUvfOu8XNrsN5KdVVgRzXKfgxA1lVQ5bzshMnq+q9bAwTIZ4608Eu6atXlxbxzCOcNhjhFo/kLDak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMpIUIex; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMpIUIex"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso508038366b.2
        for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 07:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791900624; cv=none;
        d=google.com; s=arc-20260327;
        b=UpNVtgwjcsrso9mkaviAues1LrRkQg/1S/azX7JFwsiV4zmFXcGjF4DxfCt19iOVXd
         x7UC2lxsxaIW8Key6Yub7SvLSLHim18hhGAwg0XgEBFTC7T8NYYzQpctSFImomWoa3NQ
         b867Td0OwwNRYvi1Tf4waEdYxltDFfTH2VenGE7kHWv2+27R0htfXgpQY9wMlss4KKja
         zDFnNb4UbfID8nno9vbjNRxl5zCOBLXBAe+FW44p3IHCyJhjyKAoAFa3g8XENTshQqRt
         BiZZVBsKPYIJFUe90SuIc2Vaz2eGuCBvWk2dD21A2oswCRQEk5iaSQctrPmTrLk9ux4d
         US8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNk93OG+CPbF+DX9A6OjxbQMBto1qmzwnWdWDYjiTu4=;
        fh=WuqoJfN68pqO2Tlb4jkQTX6U0v3KOR/quF33zOYdZ4Y=;
        b=oO4aZiBx6aicLVcifZKtE3ghr1w6d9Pqyi2dCaOOz452tXz0WZKBu5YVJs3iIXrkFx
         S9a2wplBrQq1xpkBHRMV8WINJry+Gb3tVmzHU/UtcfaPTFIR8bW98dNA/7Sqv+BCdWxc
         Xsr0x1m5/d+EFbLyhgUv0B2yE7bFyAkHAqGF0Q7sgyuyHKNdKUkW1YvHyLUj4ULeQ5qj
         68iKdm03g3jwgiuhYkVoQMPE0UX7qVZQHGym59YonEokYhjrjjv3Lo8Ydzs9xgBvlbyR
         rjrgn/zVvSVuXRKaxI/YGckOs/qpK1+n0AqEudVb+Fs7rIQ8KEHgIVhtpUXmYPq+AN5s
         MbfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900624; x=1792505424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wNk93OG+CPbF+DX9A6OjxbQMBto1qmzwnWdWDYjiTu4=;
        b=UMpIUIexKIlt+S/2qLmShKIqYL40su5fjH0vDa7JDYGsxP5Q+7s7mu0Lxyh7t5EvCQ
         FVdDFFoN0HEc23lKh7foz7SLYxhVFyikQFI2WvCEow5pKr2ZxAJC6KhEjaqYiZ6Y9aTi
         icmBTwWNHoxA+ou+vpB0rZefx15rweqBlu8OA4DH/wgVfwoFbqYtlB0zdwOgYmEz9wXp
         +Taqe1lULoNNvmCSaIi+0q80s5+LwcP2mxbpLFImTlVik7umIT60QGJrVhRIPYO1DrmB
         03thSI68NgFPaw0LpOo1YCEsV3kN5VWmzyfF3LLWh5VNJUJjugygiCv6ECa6StH7WoSV
         Nr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900624; x=1792505424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNk93OG+CPbF+DX9A6OjxbQMBto1qmzwnWdWDYjiTu4=;
        b=gNrT3pPp6EA/U6O7opaxNXahHe5RzX3gueMUPOy7Lba9vx4TNBZnwNjKKs6yhGVsg+
         +tT1CrRNaNt6D9M6tKuif7+us33vPNgIpKtnc26H337aVcUUWpUzKoSJgOoKhXwGWqhY
         THTw9TX2cd8u6mIzAco0+ik0j20NBdpE9jbTaiNICAH694lLwjRFBIFsYHqbVHEhzB54
         sl3m4OgOFnh/c7kzP7eVUY4gQpGMD36QeMErFLgSHYGYJNwjsKsFsQ//ECLNHg4Zy2pv
         aZopsbfOfRnZ1JyfrAZjVy5DCTXbO0lSwD/4Coz7h2qD70xgxxU+pTGZ+fauMcbAcghc
         nqSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkbqikDucm6vT0L5dRkizs3BfQL6fqpXoTMghrVpEzI7PGdEOhMk5QZ3VgNM3p3cjFKmutfftZ7Ew8@vger.kernel.org
X-Gm-Message-State: AFq9FYJ09JJ7jP8Rt1Ch/AyWlmnQDvAHivKE275an6eWi4G0WZAKBll1
	2aDdBJ0Ma+cxHtVQVZnf8IJ2UPFIsrEFhLc8XkpSEu22TY27kdd2ff+fNHxGE9tdCX9mnxpS9ug
	9BVvX/Qo7o6B+79r/ekGR195BqoNDcMo=
X-Gm-Gg: AYBFou0AUfTdpL4mDCSXjKSaTuweBFdIAsH1NSZXFRkoeWoHfhuuACASsfgv5TfybKg
	P7xM06v9mCP9vgggnTcahz8pun7xpxhTO4MJlZT2k0yIa3HmLbwvDR6wXygJbsxAWHaEJITbU4J
	YZtsOWgKxXsiDVM4nTehRC963L2RDzK3tJtVthQevLd4Km/US75CAyQNtSbccgrHAks8u09ygyR
	0gugiexCjL13HskDRqMFcLaAhjc6+sju2StulbBOlcOf5spRa0CLcBUjb2qKXoTIkJx/Pi8lzR8
	hHNjWEFVywKUWiJbktzhbX1nasA9KDJqOmFr9IJi40Y3rO1al41aH1r14Gjr/O3U9btg8EE08Ws
	=
X-Received: by 2002:a17:907:bb49:b0:c29:62d8:68af with SMTP id
 a640c23a62f3a-c31a9ffda78mr1178768966b.47.1791900624306; Tue, 13 Oct 2026
 07:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d81032ee582ede5ad2df981bb1646d096c9abe2.camel@physik.fu-berlin.de>
In-Reply-To: <8d81032ee582ede5ad2df981bb1646d096c9abe2.camel@physik.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 13 Oct 2026 16:10:12 +0200
X-Gm-Features: AclHuK879vJpsNyRaragP9VDqqMLDElAXw0wlXC4x_C0JIajBk61YZ_sEcJAGjw
Message-ID: <CA+=Fv5SuE2bgKyQCp-w+0GT=dduk3_yOSbTOzVJybC2pjLaPJw@mail.gmail.com>
Subject: Re: SPARC Meetup at FOSDEM
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Stian Halseth <stian@itx.no>, Andreas Larsson <andreas@gaisler.com>, Imre Kaloz <kaloz@kernel.org>, 
	Sam James <sam@gentoo.org>, sparclinux <sparclinux@vger.kernel.org>, 
	"<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, 
	gentoo-sparc <gentoo-sparc@lists.gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,


Great initiative!

On Tue, Oct 13, 2026 at 2:59=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi,
>
> I was wondering whether people would be interested in a SPARC meetup at F=
OSDEM?
>

This sounds very nice, I've never attended FOSDEM so maybe its about time

> I will be around as usual and maybe we could arrange a meeting with some =
hacking
> and beer.
>

Absolutely. I'll start checking my calendar

Magnus

> Adria
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
