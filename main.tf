terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "af-south-1"
}

resource "aws_connect_hours_of_operation" "Virgin-Active-Hours_of_Operation" {
  instance_id = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name        = "Virgin Active Office Hours"
  description = "Monday office hours"
  time_zone   = "EST"

  config {
    day = "MONDAY"

    end_time {
      hours   = 23
      minutes = 8
    }

    start_time {
      hours   = 8
      minutes = 0
    }
  }

  config {
    day = "TUESDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
  config {
    day = "WEDNESDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
config {
    day = "THURSDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
config {
    day = "FRIDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
  config {
    day = "SATURDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }
  config {
    day = "SUNDAY"

    end_time {
      hours   = 21
      minutes = 0
    }

    start_time {
      hours   = 9
      minutes = 0
    }
  }



  tags = {
    "Name" = "Virgin Active Hours of Operation"
  }
}
resource "aws_connect_queue" "Virgin-Active-Agent-Queue" {
  instance_id           = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name                  = "Virgin-Active-Agent-Queue"
  description           = "Queue used by Virgin Active Agents"
  hours_of_operation_id = aws_connect_hours_of_operation.Virgin-Active-Hours_of_Operation.hours_of_operation_id

  tags = {
    "Name" = "Queue for Virgin Active Agents",
  }
}

resource "aws_connect_routing_profile" "Virgin-Active-Agent-Routing-Profile" {
  instance_id               = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name                      = "Virgin-Active-Agent-Routing-Profile"
  default_outbound_queue_id = aws_connect_queue.Virgin-Active-Agent-Queue.queue_id
  description               = "Virgin Active Routing Profile for Agents"

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }

  queue_configs {
    channel  = "VOICE"
    delay    = 2
    priority = 1
    queue_id = aws_connect_queue.Virgin-Active-Agent-Queue.queue_id
  }

  tags = {
    "Name" = "Virgin-Active-Agent-Routing-Profile",
  }
}

resource "aws_connect_security_profile" "Virgin-Active-Agent-Security-Profile" {
  instance_id = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name        = "Virgin-Active-Agent-Security-Profile"
  description = "Virgin Active Agents Security Profile"

  permissions = [
    "BasicAgentAccess",
    "OutboundCallAccess",
    "VoiceId.Access",
    "SelfAssignContacts.Access",
    "ContactSearch.View",
    "MyContacts.View",
    "PhoneNumbers.Claim",
    "PhoneNumbers.Edit",
    "PhoneNumbers.Release",
    "PhoneNumbers.View",
    "SecurityProfiles.Create",
    "SecurityProfiles.Delete",
    "SecurityProfiles.Edit",
    "SecurityProfiles.View",
    "AgentStates.Create",
    "AgentStates.Edit",
    "AgentStates.EnableAndDisable",
    "AgentStates.View",
    "RealtimeContactLens.View",
    "AudioDeviceSettings.Access",
    "VideoContact.Access"
  ]

  tags = {
    "Name" = "Virgin Active Agents Security Profile"
  }
}

resource "aws_connect_user" "AgentI" {
  instance_id        = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name               = "AgentI"
  password           = "Stifler451!"
  routing_profile_id = aws_connect_routing_profile.Virgin-Active-Agent-Routing-Profile.routing_profile_id

  security_profile_ids = [
    aws_connect_security_profile.Virgin-Active-Agent-Security-Profile.security_profile_id
  ]

  identity_info {
    first_name = "Wasfee"
    last_name  = "Samsodien"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}


resource "aws_connect_user" "AgentII" {
  instance_id        = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name               = "AgentII"
  password           = "Stifler451!"
  routing_profile_id = aws_connect_routing_profile.Virgin-Active-Agent-Routing-Profile.routing_profile_id

  security_profile_ids = [
    aws_connect_security_profile.Virgin-Active-Agent-Security-Profile.security_profile_id
  ]

  identity_info {
    first_name = " Lukhanyiso"
    last_name  = "Sifumba"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}


resource "aws_connect_user" "AgentIII" {
  instance_id        = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name               = "AgentIII"
  password           = "Stifler451!"
  routing_profile_id = aws_connect_routing_profile.Virgin-Active-Agent-Routing-Profile.routing_profile_id

  security_profile_ids = [
    aws_connect_security_profile.Virgin-Active-Agent-Security-Profile.security_profile_id
  ]

  identity_info {
    first_name = "Ulrika"
    last_name  = "Fouche"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}


resource "aws_connect_user" "AgentIV" {
  instance_id        = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name               = "AgentIV"
  password           = "Stifler451!"
  routing_profile_id = aws_connect_routing_profile.Virgin-Active-Agent-Routing-Profile.routing_profile_id

  security_profile_ids = [
    aws_connect_security_profile.Virgin-Active-Agent-Security-Profile.security_profile_id
  ]

  identity_info {
    first_name = "Nomasiphiwe"
    last_name  = "Tshali"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}
resource "aws_connect_contact_flow" "Virgin-Active-Main-Contact-Flow" {
  instance_id  = "70fb22ed-9bcf-47c7-b442-6c2307be4e2c"
  name         = "Virgin-Active-Main-Contact-Flow"
  description  = "Virgin Active Main Contact Flow"
  type         = "CONTACT_FLOW"
  filename     = "Virgin-Active-Main-Line-Flow.json"
  content_hash = filebase64sha256("contact_flow.json")
  tags = {
    "Name"        = "Virgin Active Main Contact Flow",
    "Application" = "Terraform",
    "Method"      = "Create"
  }
}
