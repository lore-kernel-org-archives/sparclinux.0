Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991332A3F2;
	Mon, 18 Aug 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533855; cv=none; b=OcDAAj+Be6IdBHQVaLH6hJjA/YJmJioSqocLfttYRspxFDv3DhiugpYRRQzUz7Hijg7yhcWueQjacJNlhTPRC5MSxinfHluAoGuLwEGx4FNF5B7CUlTc6Hvng/Jtxg5sZHWIwOrJaJHdon9B2j2hBDu08jhTSlfz29RUSwLMNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533855; c=relaxed/simple;
	bh=ovJgVoYfE+uHGSM9Lf7QXN3PsWpk75cAB6j9HKK6caY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEz6TJlLyuX1fqYEQpbFRXld0sGiDq7fRwq5hsjxl2M8AzBDh0TWDDnf0r8ZPAISLBdS6JUEcJ2jO69NtNWt6rM6qOt/1XWtoswLkQdFlgiRGOa4XjV5HE9RNtbaDlNNv2Cm1C5GERju8kOV+7UyZqDITIiXeh+3T1dsDA5ohtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=pcTAibGM; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="pcTAibGM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1755533837; x=1755793037;
	bh=ovJgVoYfE+uHGSM9Lf7QXN3PsWpk75cAB6j9HKK6caY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pcTAibGM5AOO4JR8vV152dVFAFDnBJTfLuzQndPDHjyrlASDJ0aqwQqCIvky+XZRy
	 Jd7L2b5pnBDrnbp7Lxi4Rgdt8VZ4VUfGqwz9AGx0zOy5wmOSQeJVxTlhPtFNFzulj2
	 Zbjw3UyGz60x4naW9YvILnwegI2qSjscffKAgYvU8cL3qjWqXTc/G4a37PXPZ/XQ4J
	 Vp4sBFfLW08SdAiH7kRmsN9v3BS573SJChe2ri0c3FKdnq8bSBHlOngQSerSSy5DLa
	 JFNSyGba+alanC3x4RrCrS8nyUnXYSPru7jXVMx8dRLn/pZAtwOvmBWhfU2HRxiUuD
	 ZEyUirUFgyppg==
Date: Mon, 18 Aug 2025 16:17:13 +0000
To: Nathan Chancellor <nathan@kernel.org>
From: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] sparc/module: Add R_SPARC_UA64 relocation handling
Message-ID: <iKKMZJWkc4gL93yBaUVB2Pbe29zoEcqLDD5ObzZZarROyol63rNxqHS9KaZZEAtOi2pcwtPGetzw6RIffk134MSsECzCAwgMc8n7zN010mc=@protonmail.com>
In-Reply-To: <20250814224009.GA2217114@ax162>
References: <20250609-b4-sparc-relocs-v1-0-aa52631735af@protonmail.com> <20250609-b4-sparc-relocs-v1-1-aa52631735af@protonmail.com> <L-bOu33R0ouNodufTRVlvyqOoz0SGuskQ_bqQ4X_xBkw91w4XmezvmkG0p6Ith-rsFIKYSkQWHUdMJ_G0lyYJhtg18c-mfWWjPKiI_Or6cE=@protonmail.com> <20250814224009.GA2217114@ax162>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: ceb480a4b58e4ca6a93f2f0d05e44ae7db5c5c4e
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nathan Chancellor <nathan@kernel.org> wrote:

> Is there more work needed for the integrated assembler other than this
> series?

Yep~ it should be enough. The rest of the work will have to be done in
the LLVM side.
