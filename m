Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956325F98E;
	Wed,  9 Apr 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203093; cv=none; b=nIERvPnm6d/xdUA2aaScrzkeXLYw6G/d2aBQxjS2Z4S9jNMGxiqVDF0BxzC6ixdOsdSCWbXiA/Orf0xD/DXtLPRI5iVbWNjgZ4lW0C2hmnKB3Co2ZBMTIievgEYUtpevbWp2G1Rdlnlxl3p3HOfPA7bGlpOioZ4IWXeaaX7c7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203093; c=relaxed/simple;
	bh=xpH/jYiVkemK9LZOFBBqirqOj2aBQtHKu1Zu8KigTmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpAUWM+qsPL38C1Q/jSEIFH79n8lFQsnKwwB9XHnUEaU5ON4OrYPvo0Bk+PLvl+ogEnNVnFblnpw6GmikpdJUOhlXD2xWSBKxnfXU3eLkX6t8X7s3uB1/BdT4yWic6r4H8qnJrA0poalNpw+bxXAHI1ynPHgmKj7AqQXfZk/HYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZOxXxBD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZOxXxBD"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac34257295dso1347645666b.2;
        Wed, 09 Apr 2025 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203089; x=1744807889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gks++X53IVJa2PrSdYu1o6vHIrQtu/OYElJM2FQDItE=;
        b=IZOxXxBDx6kNwB9pmqpzUS6hV6vzua5U3B7qelpRVb5Zss4wZkL38oLV40o/K+ERnC
         RuvdLMUx9vF0HLg2bY6jzWxPGsNMbZnGaya7vRzCvX0urGn7nz7IFaVrCrRZgBCEgg7P
         ay0AAssBRNmET1lykDv0YnXXV9LZ/MaZ9Mf/495jArDhNewITBAe55w/1L3WNbp7L3G3
         GrV1dn1SWA/L2aMKKU4IcefxkMkDzcOgWb3xL47pBzr8ArFaUOdAyH5oCVmrBlqOW51u
         0DjSkoDJqjfQcCuX+42qtxpSenXpSu5YNYo/WVRtdS8jj9X8xp25ErRYecqM1wBQpeNn
         lawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203089; x=1744807889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gks++X53IVJa2PrSdYu1o6vHIrQtu/OYElJM2FQDItE=;
        b=XXuDrcnROG8yh/YySiDr4RLGHAYAFb2qOxuuBumqNJxqeEWWB2w3zNGd1rmRPpj+Kn
         UXliuoTSwgI+lUSAlccmdWVdCxuuND1HYJiMTsg+1TxBRyRfm76E0iwjTYn5oNToeA1g
         EfXwTeaXP0blMoPu4AQFEwMZmI6JxRtR3wzBc6bD5aUH630ebKGSEfOeqaJXqPUirA22
         pvnUD2s60JhWCrsd8WSsEaFLxlVjZHHOWLgZlT4u17JFqCUvxMSmHaGpT8yg0peiy4oj
         3lvxGuuwq3bwo+USnElQriXsSJWDPpuP6omlStMmvvbWMuvdi5cUnirgbW7vpSeyRB40
         Jn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiOsTsDklbwsLvmldBupnXAo1IARaQ7bZcFqMoHjGEHvvBVnHPfOOF/5MOTLLYXgwq8mRm8LRrBgbZuQ==@vger.kernel.org, AJvYcCXo+H7X6pfwWKyGOdN+VCN6FSy8z4XAX7riue0fg0OkFguuifKrK6GS8qMw0d3W07kLbLo7lMDbU/0JnOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGy6ajaUOP8ERnzRrbbu1TKFTsFwEQ6JH9CaMrcSwOijyjj/5
	qQ6xqvtw8QWaqw29loupMHaIZSKe7YhJaMBU+1bco1xmpnrpceqPEn8KMw==
X-Gm-Gg: ASbGnctILObVyGVNQxSyIjcYAUiQovJ/mfxLLPhBPSc/eRDsr6G+UMCTJYkv18mt8zw
	5m3uw6zJWC4MKYr9Igu+jgdB3hueOZN1gCndtnTcklxAFWSTX+Ri6xoafkKt7vDV8qzVVQWdSC/
	i6Q0ec4wnPlc5jVNi++Gn/Xh1+1lihBA6SoRe1V/68vHfrSOV3AOz3zhi2L4w+SkWFSMroPbeSw
	sT1m5+6l0N4VcQptgYVJmHSPQNm22l562oeh9lGz95T+wy3wK2V6DHaWJM3p2b/cGU5MyMZa+Xl
	PF+aTk4hMua75okIBA9xUDGgQ0QJfywuNvW6u6So
X-Google-Smtp-Source: AGHT+IFD7daTevsT5nt48BUqOknp+9ntwOoKI8U6ZrkPBPjkcnKqBAlleXU547QxwJ/c0MpNNQ+gUw==
X-Received: by 2002:a17:907:7b88:b0:ac7:684c:25ca with SMTP id a640c23a62f3a-aca9b745c3amr266597866b.51.1744203089433;
        Wed, 09 Apr 2025 05:51:29 -0700 (PDT)
Received: from pc ([196.235.3.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce7317sm91884366b.177.2025.04.09.05.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:28 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:51:25 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: pci: Fix memory leak in pci_bus_slot_names()
Message-ID: <Z_ZtTeaHpJeVH-lN@pc>
References: <Z_Ox0qp7uuKNUo2U@pc>
 <e2a4e693-46db-4b1f-87c2-2867a4cb196d@wanadoo.fr>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2a4e693-46db-4b1f-87c2-2867a4cb196d@wanadoo.fr>

On Mon, Apr 07, 2025 at 09:49:08PM +0200, Christophe JAILLET wrote:
> Le 07/04/2025 à 13:06, Salah Triki a écrit :
> > prop is a local pointer in pci_bus_slot_names(). It is initialized
> > by calling of_get_property() so the caller must free prop when done
> > using it.
> 
> Hi,
> 
> can you elaborate why?
> 
> It does not look needed to me, and the places using of_get_property() that
> I've checked don't have such a kfree().
> 
> CJ

Hi, 

Sorry for disturbing, I was wrong about that.

ST
> 
> > 
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---
> >   arch/sparc/kernel/pci.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> > index ddac216a2aff..fa0da8f45723 100644
> > --- a/arch/sparc/kernel/pci.c
> > +++ b/arch/sparc/kernel/pci.c
> > @@ -971,6 +971,8 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
> >   		mask &= ~this_bit;
> >   		i++;
> >   	}
> > +
> > +	kfree(prop);
> >   }
> >   static int __init of_pci_slot_init(void)
> 
