Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC38F40;
	Mon, 21 Jul 2025 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753063816; cv=none; b=DcvLTwyz7opPv0jMZ1g5Hu8FU71Hl+QI4J5Z/sEWc81avi+PdTZvN61AJ9m31xAQ5jPut1V/HtkzHzHkC6LgiKjkx5inwXRSgO4Wv4/xs7NjOVHHulg4GZHfhvg7qOSMFjKroiHJO7pup0aYEtAwuxuGiMl1QJOGjQZF5MeNvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753063816; c=relaxed/simple;
	bh=AIb/AVrKulOrR3Hcm14izhh45gIO4bUVAdYyicy9l8M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SfWg1HJBNJKRtiSMmVn7CegFtXn0WFxnVAZJ0bWahLk7APPPTOMyFqWilz9KImv60zG26Dltn9cczXzUsSWRvk9c0NpBX5mqnpHgntppxX1JM4WVq6tjE4jbWT1ZUfGtnFbj1RmkebauI8a+Ll+MPCvNre4P80CQ+O/Fk7pPPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RQ4ZljNB; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RQ4ZljNB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753063500; bh=+c6ItShGI1LFANcggem5ipOiNd4vPbvspZd0aUwOKms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQ4ZljNBgGPwzfK7NxW5NjyJ0XI20OG6bUjFIuKFVEKcxdlod3e7cMMrhdNJ4jAPE
	 d2BuaWFsvhiKFIqQ1iilZRmwb/L5IujLNUpTL9Y7NVLq4iVEN1zHNr8rXnBIVcBrIE
	 KdMM0dESHgAHk0y9LVu5EEboCtII/XGT25JavEII=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.37])
	by newxmesmtplogicsvrszc13-1.qq.com (NewEsmtp) with SMTP
	id 13B84045; Mon, 21 Jul 2025 10:04:59 +0800
X-QQ-mid: xmsmtpt1753063499tqzmuewmp
Message-ID: <tencent_20E2BADCCAFB7724FDBFCB3443A070A51D0A@qq.com>
X-QQ-XMAILINFO: M1JY6XCfJolWuOcfHFENl+TVww0c4Tui5YpJDb8ubg5lCRgV1BonXeh4AhqRF8
	 dqT9wdP0OeiRcQ34Q+hmh9rcN74JWp0zg6T1XHSiIdwkjG8iL+hQTSyuKvzZf6MHSUb2LSnlF9yV
	 Y7yzvgw3ilc6uI/4dQ8kpG8vCRuN+he0L+eIdoSfEliL5ZeUjEnUVTZHJ04VNFy1aDrcux9K7N1t
	 c7pqKbJjPrw2AqrUAKLFEwLBpHvX8L6STdBKOLeic0VeHwOlvkwX012KZfgzfnY+enWg5rLS2mFg
	 /jOz0OZpAcKoTSz8lAHqtgegYaJUIkhQoufDjbdB6kJIDT8MSvpgdghjj5KJZO95cDPXMb2LLUEx
	 qpaxvORX1ptHPHzYja2ptd2fWdUr481EkW8mvjSwVeZYbqawg1wVMlf1BBb1HLZoEpNUDXM3XayB
	 QVajeDL3IR7cqceG835VTZbgweOQnPNAOil+Pt/LEXu4AXoGA4K5tkmkuSuL0MnR0IGqvLXAwSpU
	 AzATU3r4SFniqd64TG791/Ex+LEcnqNT6F6/skqbGZIJ6UPM58QlDskhqtd7kNjgPZAs+VtRqC7o
	 MJDgUOUt1gosk+KGAsy47O5TtsCBPEV27ytxAH3NpwIYUw6Ivl1MKkEsHSJg0uH6g01Edr4189lJ
	 rhMf10kT+8QyuHAor7/t/Q8tUjRJjKP+sqMnHi4DdMqEL56dsGPnH9fc8UZ5xtCvSf3lIi2uxeGw
	 OeAUYmzHogarO2IFlyhCGdNzxbHaxif1q0r0kUborwECgk4PSJjPnTYuXVYfB/2ciiMgxignawUi
	 w0IlToHRE4hvqrzVrISz4HBUr7fBOr4jOLadl4P+eYfUNl89/KNXOKaoTgbyYOJL30nM+5hEei4m
	 UJLtcAOJh8s/OBbvw5YPktIzK1SSANmslDvWmYZSDab8lvn3OigP6bnzFrNkBkTb9SkUXwK37dSB
	 d5E2A3NqDVv/BDA2it9ArnDlBfPc+eug5lSHggjzoiLpt5/a1ZmlrbqcW7wE7+BSZudKyF0f5BPh
	 xOxTufyjWHn3UW2EmTKnKteSoTb9ewVoYtmav9ykofFx1svPf6oMSWrQzlbp0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: jackysliu <1972843537@qq.com>
To: krzk@kernel.org
Cc: 1972843537@qq.com,
	andreas@gaisler.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: Re:[PATCH] arch: fix resource leak in chmc.c
Date: Mon, 21 Jul 2025 10:04:54 +0800
X-OQ-MSGID: <20250721020454.4174560-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <25e7455e-816c-448a-b78b-94fe9437e3c8@kernel.org>
References: <25e7455e-816c-448a-b78b-94fe9437e3c8@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 18 2025 15:25:47 +0200  Krzysztof Kozlowski wrote:
>Last time you were using AI, so I have doubts this is "static tools".
>Please describe it properly, so we can make informed decision whether to
>allocate time on this.

The tool determines which api is responsible for resource request 
and release, and determines if there are resource leak or double free 
issues in the code by determining the use of release specifications.
So no AI involved, don't worry.

>Nah, just free it immediately after user. Don't over complicate this.
OK, I'll resubmit a new patch later


Siyang Liu

