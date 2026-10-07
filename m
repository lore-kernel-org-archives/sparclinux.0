Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446C314B8F
	for <sparclinux@vger.kernel.org>; Wed,  7 Oct 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389376; cv=pass; b=YOeAcnswKWtsxkPBvvjwA2ohCx7bBVsHXU7X0977Lzaej63gboJmjQLPEIt3SxdRQnhfU96ZI8fUc7smMDXpIVKErehiTJvIvayzVMwJyvRn86+acNR/NMD0NmWfq48WkGhyEi00/SkId3DLYXByom+6Fu6dznpX8X1d1F3n02o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389376; c=relaxed/simple;
	bh=ttUqta9PGbTX1cLeWkyGruVCwYrxrxBN57lkJEb1MDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnfW4jziMxYYsiTPRWWDMR1dKhp/dqsOIK1+gDXrtIYXb7Dt6iuKD7wmh8X91b51CpLKyziIo5mlS+VOJZd6PkBWCKJ5GCjuE/z1O6h8RTZ32hTP2/LwWRTvSawzO4wAuGoskbs7RB8ukPLwhSEX01z4aN9bclz7WFpSN3X4E6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+eQ6JI9; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+eQ6JI9"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso3141753a12.3
        for <sparclinux@vger.kernel.org>; Wed, 07 Oct 2026 09:09:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791389373; cv=none;
        d=google.com; s=arc-20260327;
        b=CEYxRoV4nnY/2kw3BcbPjDFiPGFAiIgE+aw7VsI/u+6f/0P/dO89olDWcMF6RfbXrD
         jwSqOlXnK3Q8jWVuibEJtk5ENPhSZgA6LaD03fv8stxABmzu8VT/YHzO9+7pidXcQhWJ
         zN2UACXp8PC0LGuOUsf1ueuK4IEDpMfQKuhEVXH+Ikz5fIFZYPh1/u1FD6QUdFI1nGgR
         5qytB4/mWgYK9P1qtuovYwR3TF9sQR7vxgOmRM0lJ3cO6UFXdBc5Esckx4Sgg6KVPCQQ
         hPV2D/WmM7TySyHNjUADomF/YjxRwf2OKAPXOmqHQC9L048CTg9NgefnX1CdQfUpwCG8
         xJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ttUqta9PGbTX1cLeWkyGruVCwYrxrxBN57lkJEb1MDE=;
        fh=zt1Sf6gB1nm6At7XwWyKP+NT72b+ui11ZzRXfOzX6DA=;
        b=XdItq3s394aNT4Os2PxcFkstqTNCqBMw2cvObcDBuYR0iez+pXy0E3OAKY5dvfAL6k
         NgRkWVCOiAQx/TfIAuOmox6S/D+fhCAgmknyS9cQoftRNU+NzO0FvWW7O6Hq/spUqweT
         5pEGQG1co2aDsZ9QIqEBV8RJmR7LyvjRsMuTTPKXTGmQUGdqCKp1i3rYq0vXMyTLv7So
         Lr7Je2DDiDxgYcWWxuyDOTs5Tsq2scKkLzh3cSLc8wGqYnAUtAjfHiUetLSNPQqgH4zT
         PbFDeDKRTFEhCKW/If2/v9VGP2Jz9YcLsP+8jGIxtRtlXshiTh2NdoimLo67EG7nCOEX
         aMJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791389373; x=1791994173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ttUqta9PGbTX1cLeWkyGruVCwYrxrxBN57lkJEb1MDE=;
        b=B+eQ6JI99shTilPYkPz0/5ExNCDh554HrDBqDiiYEq3IL/8y0R2qnd+hmKqwFmmxiz
         b5gUt0ReAH0njscgei3XjR2ag1gdlHZYliq+8mBASo3/8DjpYC76zWLq1uiu+XOqMkUG
         0kw0cLkv6UjjqD/tSvEHfEv9dHZGWn+oRCdS8MzEgbe9sGX/GgIfO+aj2WDNe2IbIZBb
         HtAqyv/n4w8PT0I7nU9UeFQCnt4NhnQicZikFlgzu39f6pvwmEz80czPRlwL3G9tOsuZ
         yYghrlNnwd9DgvsqRpe8B40+pXjQt/GBofo8yk+Dc995gkXzGuBvFCYz+izA89idGUB3
         /k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791389373; x=1791994173;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ttUqta9PGbTX1cLeWkyGruVCwYrxrxBN57lkJEb1MDE=;
        b=q8ATPx4qD9oF4VPrCkTG3zaExK2M+NGzO+i0SqGsZKO/Kqs6ou5hI3v+My+gE2qKbP
         mUEa42PVgf3veoWCgJlFibq/Z0pnl4dkaKGjN4yqnErUGqzYVzcHqvqapi6JVMrqq6oW
         bHPw7p4/HkC8foxAjwsWl3Aqw8sMdXpOoaK7qXOiZSba2a+Mho1L/I8Va8CxUA5/d4Y5
         PohN2Vo8CGGuHlMB/lzG+TGHWA4NPJZ1/CsYBMqp1wGEARRuQrCQaNCpcCE8qp3UpSAt
         IiAFyJ2Hc27W2vcD4z6b8r1Gez3Nj0c7X57Jsh+lyKZL0bR9VTvCexk/p+16OJibFPai
         Lwfg==
X-Forwarded-Encrypted: i=1; AKwUvBwSplO+XKiRfXdW3FUN569CJbG/XXLWs0DHlAHJlPtBktSg7/ZkcxvCZd1olo6kqyNeud5luunD1/Pd@vger.kernel.org
X-Gm-Message-State: AFq9FYIpSwpJSnqA0/f/tpRbxhYgOXSiRzEds30n+Kd+iffBXZevfOYy
	u420PE2ilUr8at+XJXCrj4ooHOYpeexlx0XbFLSwvaXwclwRpaIO0+QaC6UVW7iH1+6YyHx5Z3S
	sUSit3ldlHznksEZZphBGFx1V64gAbNjNPFMO
X-Gm-Gg: AYBFou0H1zaVw+NTg0+pcyeSOj2JxK3JZ35PmRQwCyUD6LQb6WajqVLUMxCrgPRYe0+
	LrbeavPdA6y0w1GSnZmwkNsyH4hVJPXGa9fBe+j4jz6ldcsgKp5r7TvR8C7Xbu9G9d6/im5t6pe
	fKOc8EAlRR+cOg/uPTBvXpznx9sU/1BeAObM+dun+yBsRxQlGNC0fdXPYX0xyJ6Sqtyji9/NDA7
	7ivuGIWvT2W+9kuYNRsPkmaGOGsCG2T+vRUV8VkrOJIohOpbXTFtrZIsYfvrbCRuUnOXOwQT2+n
	tEXH2+OzOq/zRn/5Nb1n3vBvCLICrpHdIEJ7XdeQX3sASXWUwLFoLCE/ReMgqzD33/c4OKjbRJC
	GenbPaSbm0YaoXuRFh9vbcjVgvjxyU9yU//bYXDEsuw==
X-Received: by 2002:a05:6402:5112:b0:6af:dc4c:5f28 with SMTP id
 4fb4d7f45d1cf-6aff455444fmr2701133a12.37.1791389372670; Wed, 07 Oct 2026
 09:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927214334.886582-1-linmag7@gmail.com> <20260927214334.886582-6-linmag7@gmail.com>
 <2b6757c5-4cbc-488e-bc3d-42a79c7273f8@gaisler.com>
In-Reply-To: <2b6757c5-4cbc-488e-bc3d-42a79c7273f8@gaisler.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 7 Oct 2026 18:09:20 +0200
X-Gm-Features: AclHuK-43SsAtTuiKbLSF6aEake8k_sveddO-CwzpwJVeaZpYAnQmihwoGLUUn0
Message-ID: <CA+=Fv5S69bJDnhugt4AF1BRHkhhsvfpCmt29Ox_ZrvRW6L+ZVg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] sparc32: move early memory setup to setup_arch
To: Andreas Larsson <andreas@gaisler.com>
Cc: davem@davemloft.net, sam@ravnborg.org, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Wed, Oct 7, 2026 at 7:48=E2=80=AFAM Andreas Larsson <andreas@gaisler.com=
> wrote:
>
>>
> ...and does not apply on top of that.
>
> Please rework the series on top of the for-next branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git
>

Sorry, my bad. v4 was still based on the older relocation
patches. I have rebased v5 onto your for-next branch and resolved patch 5
while preserving the sun4m/sun4d probe restriction and the updated
phys_base diagnostics. Sam's Reviewed-by tags are retained.

The series now applies cleanly on top of your for-next and both the SS20 SM=
P
and LEON/HIGHMEM builds pass. Boot-tested on a dual-HyperSPARC
SPARCstation 20, with Imre Kaloz=E2=80=99s SMP futex, CASA and integer-divi=
sion
emulation patches applied on top.

I'll send v5 shortly.

Thanks,
Magnus
