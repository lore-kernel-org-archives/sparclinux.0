Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29023AE189;
	Thu,  8 Oct 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478684; cv=none; b=VbKBdqs66r+i3o8ubVTdaxyKr83WjaYn0vsnOHvuAmNG6o6Kql+G1JqiCR/1DC77v8ENyYJ6qTMKHIa3E264itNxTXz48LU323OsTZ1i7LdF12Fv0cV+gSNxRjTpXyiOObRFUzSHDFcok3NuYe6++WW+G8R4Q1p+HxcSY/Kn7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478684; c=relaxed/simple;
	bh=bynOu2VVA72prN24Xy+UakvuCQ146mGe8mEfTvLQ3ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQ36/i9MMGHmA8ZUM6NP3QWxSfxCnKGlX1G5w7lBePLWmqPW9QRIej4IBuHXtIbxJe9AdHQirPDpxu9tsHD+qurHc/ODi2OUBBovtly+PpxQFWPjF/2snYW2+XS3U5l86YRYGqIhIyJl3i70Wu0OPexPalQXr2cO5HmFCVIF6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abL6vRrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abL6vRrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E531F000FF;
	Thu,  8 Oct 2026 16:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791478683;
	bh=p5eX40+0pn1pqE4X9p/3mX7zpxCpkri1+KVRhfpZsT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=abL6vRrd0ntFtVMoFQ/S1X5sm2014bqOqldWw36Bn1C3vW5ppKACQ7NRtQQF7XPZ4
	 VkP7eGvgi+8Yj0F/rH8CCC191kC4PFbSqM5bhbZz/LoxsNF7rGhul0w24ekrS464cg
	 n9gHg8sDCmQGcqsb5+7czMtOYUXjdtQT7o1IHH26X0NrL6C1MIlaPXnQvejk0dYvZu
	 GvscA18TTnuvC7s/zDhe3fPVtWGXLznyE0J1wvctt0bBFPeLKUnJKsJ4vOqJhHJPsm
	 GDnduMKHdqWEXLUKpPvI06l905eNL+cUt3qdPT5VbsRDrUwGkY/XvTZc8vh9HRMVn6
	 RbLoIUDvp5O3w==
Date: Thu, 8 Oct 2026 09:58:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 6/7] tg3: normalize inherited M3000 register byte order
Message-ID: <20261008095802.79671bd1@kernel.org>
In-Reply-To: <20261002161515.932316-7-linmag7@gmail.com>
References: <20261002161515.932316-1-linmag7@gmail.com>
	<20261002161515.932316-7-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Oct 2026 18:14:28 +0200 Magnus Lindholm wrote:
> M3000 firmware can leave BCM5718 vendor registers byte-swapped while
> standard PCI fields retain normal byte order. Match the Fujitsu 10cf:165a
> subsystem, IKKAKU model and swapped revision/product signature before
> restoring host control; reject failed PCI accesses or register readbacks.

Is there any dependency on other patches in the series?
if not please send this patch out separately 
-- 
pw-bot: cr
